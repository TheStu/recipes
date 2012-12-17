desc "Update the links table"
task :links => :environment do

  require 'open-uri'
  require 'nokogiri'
  
  #update the food links for the sidebar
  
  Link.where("link_type = ?", 'sidebar').delete_all

  url = "http://www.avantlink.com/api.php?affiliate_id=31645&module=ProductSearch&output=xml&website_id=124521&search_term=Backpacker%27s+Pantry%7CMountain+House%7C+Mary+Janes+Farm&search_advanced_syntax=1&merchant_ids=10060%7C10248&search_results_fields=Merchant+Name%7CProduct+Name%7CRetail+Price%7CSale+Price%7CAbbreviated+Description%7CThumbnail+Image%7CBuy+URL&search_results_count=3&search_results_sort_order=Price+Discount+Percent%7Cdesc&search_results_options=precise%7Cinterleave"

  doc = Nokogiri::XML.parse(open(url))
  my_hash = doc.search('//Table1').map{ |e| Hash.from_xml(e.to_xml)['Table1'] }
  my_hash.each do |hash|
    new_hash = {}
    hash.each do |key, value|
      new_hash[key.downcase] = value
    end
    new_hash['link_type'] = 'sidebar'
    new_hash['sidebar'] = true
    Link.new(new_hash).save
  end
  
  #update the equipment links for the sidebar and camping cooking gear page
  
  word_list = ['stove', 'pot|pan', 'stove+accessory', 'spoon|spatula', 'plate|bowl', 'spork|spoon', 'knife', 'cup|mug', 'soap|cooking']
  
  word_list.each do |search_term| 
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
