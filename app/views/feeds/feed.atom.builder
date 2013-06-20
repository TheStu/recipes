atom_feed :language => 'en-US' do |feed|
  feed.title "Camping Recipes"
  feed.updated Recipe.maximum('created_at')
  @recipes.each do |recipe|
    feed.entry recipe do |entry|
      entry.title recipe.title
      entry.content recipe.introduction, type: 'html'
      entry.author do |author|
        author.name recipe.user.username
      end
    end
  end
end
