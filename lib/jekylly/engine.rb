require 'kramdown'

module Jekylly
  class Engine < ::Rails::Engine
    isolate_namespace Jekylly
  
    module MarkdownHandler
      def self.erb
        @erb ||= ActionView::Template.registered_template_handler(:erb)
      end
      
      def self.call(template)
        compiled_source = erb.call(template)
        "Kramdown::Document.new(begin;#{compiled_source};end, auto_ids: true).to_html.html_safe"
      end
    end
    
    ActionView::Template.register_template_handler :md, MarkdownHandler
    ActionView::Template.register_template_handler :markdown, MarkdownHandler
    
    def self.site_posts
      @@posts ||= begin
        prefix = "#{Rails.root}/app/views/static/"
        post_files = Dir.glob("#{prefix}**/_posts/**")        
        post_paths = post_files.map{|file| file.gsub(prefix,'')}
        post_paths.map { |path| Jekylly::Post.new(path) }
      end
    end
    
  end
end
