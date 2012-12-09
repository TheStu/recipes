module ApplicationHelper

  def full_title(page_title) #Returns the full title on a per-page basis.
    base_title = "Camping Recipes"
    if page_title.empty?
      base_title
    elsif page_title == "home"
      "#{base_title} | Recipes to take Camping and Backpacking"
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def meta_desc(desc) #Returns the full title on a per-page basis.
    if desc.empty?
      "Camping recipes and backpacking recipes to keep you well fed while working hard in the outdoors"
    else
      desc
    end
  end
  
  def pretty_date(date)
    date = date.to_date
    new_date = date.strftime("%b #{date.day.ordinalize}, %Y")
  end
  
  def flash_class(level) #change rails alerts in to bootstrap alerts (associated partial and application.html code)
   case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
  
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
