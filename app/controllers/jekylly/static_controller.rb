module Jekylly
  class StaticController < ApplicationController
    
    before_filter :parse_path
    before_filter :load_metadata
    
    def show
      # Setup render options
      options = {
        file: @filename,
        layout: "default"
      }
      # Set layout for rendering
      options[:layout] = @metadata['layout'] if @metadata['layout']
      # Render through the usual pipeline
      str = render_to_string options
      # Strip YAML frontmatter from output
      str.gsub!(/---$.*?^---$/m,'') # post-HTML
      str.gsub!(/\<p\>.*?—\<\/p\>/m,'') # post-Markdown
      # Render out to response
      render inline: str.html_safe
    end

    private

    def parse_path
      path = params[:path]
      @type = "page"
      @filename = Dir.glob(File.join(Rails.root, "app/views/static", "#{path}.*")).first
      post = Jekylly::Engine.site_posts.find{|x| x.url == params[:path]}
      if post
        @type = "post"
        @filename = Dir.glob(File.join(Rails.root, "app/views/static", post.path)).first
      end
      @action = path
      # Chuck a 404 if the @filename is nil
      if @filename.nil?
        # 404
      end
    end
    
    def load_metadata
      @metadata = YAML.load_file(@filename) || {}
    end

    def jekyll_config
      @@jekyll_config ||= YAML.load_file(File.join(Rails.root, "app/views/static/_config.yml")) rescue {}
    end

  end
end