require 'rest-client'
require 'open-uri'
require 'nokogiri'
require 'debugger'

class HackerNewsClient
  def initialize
    @page = Nokogiri::HTML(
    RestClient.get("http://news.ycombinator.com/"))
  end

  def get_front_page
    story_rows = @page.css("table tr:nth-of-type(3) table") #> td.title > a
    stories = []
    
    story_rows.each do |story_row|
      title = story_row.css("tr")[0].css("td.title > a").text
      article_href = story_row.css("tr")[0].css("td.title > a").attr('href')
      #link = story_row.css("td.title > a")[0]
      #title = link.text
      debugger
      # p title
      # article_href = link.attr('href')

      stories << {:title => title, :article_href => article_href}
    end

    # link_tags = @page.css("tr > td.subtext")

    # link_tags.each_with_index do |link, link_i|
    #   user_name = link.css("a")[0].text
    #   p user_name
    #   comments = link.css("a")[1].text
    #   p comments
    #   user_href = link.css("a")[0].attr('href')
    #   p user_href
    #   comments_href = link.css("a")[1].attr('href')
    #   p comments_href

    #   stories[link_i][:user_href] = user_href
    #   stories[link_i][:user_name] = user_name
    #   stories[link_i][:comments] = comments
    #   stories[link_i][:comments_href] = comments_href

    #   p stories
    # end

    story_objects = []
    stories.each do |hash|
      story_objects << Story.new(hash)
    end

    story_objects.each do |story|
      story.show_story
    end

    return nil
  end
end

class Story
  def initialize(hash)
    @title, @article_href = hash[:title], hash[:article_href]
    # @user_name, @user_href = hash[:user_name], hash[:user_href]
    # @comments, @comments_href = hash[:comments], hash[:comments_href]
  end

  def show_story
    puts "#{@item_num+1}"
    puts "title: #{@title}"
    puts "article_href: #{@article_href}"
    # puts "posted by #{@user_name}: #{@user_href}"
    # puts "received #{@comments}: #{@comments_href}"
  end
end