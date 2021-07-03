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
        arr_category << {category_link: link.css('a').first['href'], category_name: link.content}
      rescue
        puts "Error here: #{link}"
      end
    end
    arr_category
  end

  # start using link category to get all products
  def collect_product_paging(category)
    get_total_paging = using_nokogiri(category[:category_link]).css("div.paging ul li.hidden-xs").first.content.to_i || 1
    Category.find_or_create_by(name: category[:category_name])

    (1..get_total_paging).each do |page|
      get_product_links(("#{category[:category_link]}?page=#{page}"))
    end
  end

  # collect all product
  def get_product_links(product_url)
    arr_product_list = []
    document = using_nokogiri(product_url)
    document.css("div.listComic ul.list li").each do |item|
      begin
        arr_product_list << item.css("div.detail h3 a").first["href"]
      rescue
        puts "Error product detail here: #{item}"
      end
    end

    arr_product_list.each do |item|
      get_chapter_detail(item)
    end
  end

  # collect chapter
  def get_chapter_detail(chapter_url)
    document = using_nokogiri(chapter_url)
  end

  def save_to_db
  end
end