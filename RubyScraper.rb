#!/usr/bin/env ruby

require 'anemone'
require 'nokogiri'

Anemone.crawl("http://www.hackerschool.com/") do |anemone|
  anemone.on_every_page do |page|
    @page = page.body
    @doc = Nokogiri::HTML.parse(@page)
    @doc.xpath('//p/text()').each do |p_tag|
      puts p_tag.content
    end
  end
end
