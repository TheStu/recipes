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
  
  def flash_class(level) #change rails alerts in to bootstrap alerts (associated partial and application.html code)
   case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |ing|
      render(association.to_s.singularize + "_fields", :f => ing)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
