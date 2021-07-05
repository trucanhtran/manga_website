require 'nokogiri'
require 'open-uri'
require 'rubygems'

class Beeng
  attr_accessor :url
  def initialize
    @url = "https://beeng.org/"
  end

  def using_nokogiri(current_url)
    doc = Nokogiri::HTML(URI.open(current_url))
  end

  def start_parsing
    raw_home_page = using_nokogiri(@url)
    arr_category = collect_category(raw_home_page)

    arr_category.each do |item|
      begin
        collect_product_paging(item)
      rescue
        puts "Error product here: #{item[:category_link]}"
      end
    end

  end

  # start crawl home page and get all categories links then save it to array hash
  # [{category_link: "", category_name: ""}]
  def collect_category(raw_home_page)
    arr_category = []
    raw_home_page.css("nav div ul.navbar-nav li.nav-item ul.dropdown-menu li").each do |link|
      begin
        puts "#{Time.zone.now} start crawling category"
        arr_category << {category_link: link.css('a').first['href'], category_name: link.content}
      rescue
        puts "Error category here: #{link}"
      end
    end
    arr_category
  end

  # start using link category to get all products
  def collect_product_paging(category)
    puts "#{Time.zone.now} start crawling paging category"
    get_total_paging = using_nokogiri(category[:category_link]).css("div.paging ul li.hidden-xs").first.content.to_i || 1
    current_category = Category.find_or_create_by(name: category[:category_name])

    (1..get_total_paging).each do |page|
      get_product_links(("#{category[:category_link]}?page=#{page}"), current_category)
    end
  end

  # collect all product
  def get_product_links(product_url, current_category)
    arr_product_list = []
    document = using_nokogiri(product_url)
    document.css("div.listComic ul.list li").each do |item|
      begin
        puts "#{Time.zone.now} start crawling link to chapters"
        arr_product_list << item.css("div.detail h3 a").first["href"]
      rescue
        puts "Error product detail here: #{item}"
      end
    end

    arr_product_list.each do |item|
      get_chapter_detail(item, current_category)
    end
  end

  # collect chapter
  def get_chapter_detail(chapter_url, current_category)
    document = using_nokogiri(chapter_url)
    arr_chapters = []
    title = document.css("div.detail h1").first.content
    short_description = document.css("div.shortDetail").first.content.strip
    current_view_counts = document.at('ul li:contains("Lượt xem")').content.squish.gsub("Lượt xem:", "").squish.gsub(",", "").to_i
    thumbnail_url = document.at('div.cover img').attribute('src').value

    document.css('div.listChapters ul.list li').each do |item|
      begin
        title_chapter = item.at("a span.name span.titleComic").content.squish
        puts "Title chapter: #{title_chapter}, link chapter: #{chapter_url}"
        arr_chapters << {url: item.at("a").attribute("href").value, title: title_chapter}
      rescue
        puts "Error get chapter detail #{item}"
      end
    end

    begin
      current_product = current_category.products.find_by(title: title)
      puts "Start import product #{title}"
      if current_product
        current_product.short_description = short_description
        current_product.current_view_counts = current_view_counts
        current_product.thumbnail_url = thumbnail_url

        current_product.save
      else
        current_product = current_category.products.create({
          title: title,
          short_description: short_description,
          current_view_counts: current_view_counts,
          thumbnail_url: thumbnail_url
        })
      end
      arr_chapters.each do |chapter|
        get_all_images_chapter(chapter, current_product)
      end

    rescue
      puts "Error when import database"
    end
  end

  def get_all_images_chapter(chapter, current_product)
    document = using_nokogiri(chapter[:url])
    arr_chapters = []
    begin
      document.css("div.readComic div.container-fuild img").each do |item|
        arr_chapters << item.attribute("src").value
      end
      save_to_db(arr_chapters, current_product, chapter[:title])
    rescue
      puts "Get chapter is error #{chapter[:url]}"
    end
  end

  def save_to_db(arr_chapters, current_product, title_chapter)
    current_chapter = current_product.chapters.find_by(title: title_chapter)
    puts "Start import chapter #{title_chapter}"
    if current_chapter
      current_chapter.image_list = arr_chapters.join(",")
      current_chapter.save
    else
      current_product.chapters.create({
        title: title_chapter,
        image_list: arr_chapters.join(",")
      })
    end
    puts "Finish import chapter #{title_chapter}"
  end
end