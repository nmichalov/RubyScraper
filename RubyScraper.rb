#!/usr/bin/env ruby

require 'anemone'
require 'nokogiri'

class DomainScraper
  url_hash = Hash.new
  count = 0
  puts "Enter a domain to scrape:"
  @domain = gets
  Anemone.crawl(@domain) do |anemone|
    anemone.on_every_page do |page|
      @out_file = count.to_s()
      url_hash[count] = page.url.to_s()
      @page = page.body
      @doc = Nokogiri::HTML.parse(@page)
      @doc.xpath('//p/text()').each do |p_tag|
        File.open(@out_file, 'a') {|f| f.write(p_tag.content) }
      end
      count += 1
    end
  end
  puts url_hash
end

DomainScraper
