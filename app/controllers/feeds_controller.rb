class FeedsController < ApplicationController

  def feed

    # the news items
    @recipes = Recipe.order("updated_at desc")

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

end
