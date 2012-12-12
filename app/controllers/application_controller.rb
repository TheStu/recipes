class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path
    flash[:error] = "Please sign in or sign up before continuing"
  end
  
  if Link.where("link_type = ?", "sidebar").count != 5 || Time.now - 24.hour > Link.where("link_type = ?", "sidebar").first.created_at
    require 'open-uri'
    require 'nokogiri'
    
    Link.where("link_type = ?", 'sidebar').delete_all

    url = "http://www.avantlink.com/api.php?affiliate_id=31645&module=ProductSearch&output=xml&website_id=124521&search_term=Backpacker%27s+Pantry%7CMountain+House%7C+Mary+Janes+Farm&search_advanced_syntax=1&merchant_ids=10060%7C10248&search_results_fields=Merchant+Name%7CProduct+Name%7CRetail+Price%7CSale+Price%7CAbbreviated+Description%7CThumbnail+Image%7CBuy+URL&search_results_count=5&search_results_sort_order=Price+Discount+Percent%7Cdesc&search_results_options=precise%7Cinterleave"

    doc = Nokogiri::XML.parse(open(url))
    my_hash = doc.search('//Table1').map{ |e| Hash.from_xml(e.to_xml)['Table1'] }
    my_hash.each do |hash|
      new_hash = {}
      hash.each do |key, value|
        new_hash[key.downcase] = value
      end
      new_hash['link_type'] = 'sidebar'
      Link.new(new_hash).save
    end
  end
end
