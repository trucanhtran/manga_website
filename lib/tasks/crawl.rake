require './lib/tasks/sites/beeng.rb'

namespace :crawl do
  # https://beeng.org/
  desc "Start crawl data from beeng.org"
  task beeng: :environment do
    Beeng.new.start_parsing
  end

end
