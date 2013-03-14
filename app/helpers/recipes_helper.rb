module RecipesHelper
  def convert_to_pounds(grams)
    weight = grams / 453.592.to_f
    weight.round(2)
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

  def link_to_remove(name)
    hidden_field_tag(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add(name, association)
    fields = render(association.to_s.singularize + "_fields")
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_hard_remove(name)
    link_to_function(name, "hard_remove_fields(this)")
  end
end
