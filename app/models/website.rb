class Website < ActiveRecord::Base
  require 'open-uri'

  def self.get_websites(user_website)
    websites = ['http://www.nfl.com/news', 'http://www.nba.com/news', 'http://espn.go.com/nfl', 'http://espn.go.com/nba']
    keyword_array = [' out ', ' injur', ' start', ' concuss', ' bench', ' broke', ]
    websites.each do |website|
    page = Nokogiri::HTML(open("#{website}"))   
    links = page.css('a')
      links.each do |link|
        keyword_array.each do |key|
          if link.text.include? (key)
            if !link['href'].include? ('http')
              href = website + link['href']
            else
              href = link['href']
            end
            Website.create(:title => link.text, :href => href)
          end
        end
      end
    end
  end

  def self.get_user_websites(user_website)
    keyword_array = [' out ', ' injur', ' start', ' concuss', ' bench', ' broke', ]
    page = Nokogiri::HTML(open("#{user_website}"))   
    links = page.css('a')
    links.each do |link|
      keyword_array.each do |key|
        if link.text.include? (key)
          if !link['href'].include? ('http')
            href = user_website + link['href']
          else
            href = link['href']
          end
          Website.create(:title => link.text, :href => href)
        end
      end
    end
  end
end
