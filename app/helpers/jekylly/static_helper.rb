module Jekylly
  module StaticHelper
  
    def markdown(source)
      Kramdown::Document.new(source).to_html.html_safe
    end
    
    def site_data(name)
      YAML.load_file(File.expand_path("app/views/static/_data/#{name}.yml", Rails.root))
    end
    
    def include(template, parameters = {})
      render partial: "static/_includes/#{template}", locals: parameters
    end
    
  end
end