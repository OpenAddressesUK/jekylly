module Jekylly
  module StaticHelper
  
    def markdown(source)
      Kramdown::Document.new(source).to_html.html_safe
    end
    
    def site_data(name)
      Jekylly::Engine.site_data(name)
    end

    def site_posts
      Jekylly::Engine.site_posts
    end
    
    def include(template, parameters = {})
      render partial: "static/_includes/#{template}", locals: parameters
    end
    
  end
end