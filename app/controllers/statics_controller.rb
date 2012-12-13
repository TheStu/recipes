class StaticsController < ApplicationController
  def home
    @recipes = Recipe.order('created_at desc').first(5)
  end

  def contact
  end

  def about
  end

  def privacy
  end
  
  def gear
    if Link.where("link_type = ?", "stove").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "stove").first.created_at
      update_links('stove')
    elsif Link.where("link_type = ?", "pot|pan").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "pot|pan").first.created_at
      update_links('pot|pan')
    elsif Link.where("link_type = ?", "stove+accessory").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "stove+accessory").first.created_at
      update_links('stove+accessory')
    elsif Link.where("link_type = ?", "spoon|spatula").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "spoon|spatula").first.created_at
      update_links('spoon|spatula')
    elsif Link.where("link_type = ?", "plate|bowl").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "plate|bowl").first.created_at
      update_links('plate|bowl')
    elsif Link.where("link_type = ?", "spork|spoon").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "spork|spoon").first.created_at
      update_links('spork|spoon')
    elsif Link.where("link_type = ?", "knife").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "knife").first.created_at
      update_links('knife')
    elsif Link.where("link_type = ?", "cup|mug").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "cup|mug").first.created_at
      update_links('cup|mug')
    elsif Link.where("link_type = ?", "soap|cooking").count != 2 || Time.now - 24.hour > Link.where("link_type = ?", "soap|cooking").first.created_at
      update_links('soap|cooking')
    end
    
    @stoves = Link.where("link_type = ?", "stove")
    @pots = Link.where("link_type = ?", "pot|pan")
    @accessories = Link.where("link_type = ?", "stove+accessory")
    @spoons = Link.where("link_type = ?", "spoon|spatula")
    @plates = Link.where("link_type = ?", "plate|bowl")
    @sporks = Link.where("link_type = ?", "spork|spoon")
    @knives = Link.where("link_type = ?", "knife")
    @mugs = Link.where("link_type = ?", "cup|mug")
    @soaps = Link.where("link_type = ?", "soap|cooking")
  end
  
  private
  
  def update_links(search_term)
    require 'open-uri'
    require 'nokogiri'
    
    Link.where("link_type = ?", search_term).delete_all
    
    url = "http://www.avantlink.com/api.php?affiliate_id=31645&module=ProductSearch&output=xml&website_id=125133&search_term=#{CGI.escape(search_term)}&search_advanced_syntax=1&merchant_ids=10060%7C10248&search_results_fields=Merchant+Name%7CProduct+Name%7CRetail+Price%7CSale+Price%7CAbbreviated+Description%7CThumbnail+Image%7CBuy+URL&search_results_count=2&search_results_sort_order=Price+Discount+Percent%7Cdesc&search_results_options=interleave%7Cprecise"

    doc = Nokogiri::XML.parse(open(url))
    my_hash = doc.search('//Table1').map{ |e| Hash.from_xml(e.to_xml)['Table1'] }
    my_hash.each_with_index do |hash, i|
      new_hash = {}
      hash.each do |key, value|
        new_hash[key.downcase] = value
      end
      new_hash['link_type'] = search_term
      new_hash['sidebar'] = true if i == 0 && ['stove', 'pot|pan', 'plate|bowl'].include?(search_term)
        
      Link.new(new_hash).save
    end
  end
end
