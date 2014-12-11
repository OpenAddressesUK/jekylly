module Jekylly
  class StaticController < ApplicationController
    
    before_filter :parse_path
    before_filter :load_metadata
    
    def show
      # Setup render options
      options = {
        template: "static/#{@action}",
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

    def posts
      @@posts ||= begin
        prefix = "#{Rails.root}/app/views/static/"
        post_files = Dir.glob("#{prefix}**/_posts/**")
        post_paths = post_files.map{|file| file.gsub(prefix,'')}
        Hash[post_paths.map{|path| [pretty_post_path(path), path]}]
      end
    end

    def parse_path
      path = params[:path]
      @type = "page"
      @filename = Dir.glob(File.join(Rails.root, "app/views/static", "#{path}.*")).first
      if posts[params[:path]]
        path = posts[params[:path]] 
        @type = "post"
        @filename = Dir.glob(File.join(Rails.root, "app/views/static", path)).first
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

    def pretty_post_path(filename)
      parsed = filename.match /(.*?)\/?_posts\/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.+?)\./
      segments = parsed.to_a.slice(1,5).delete_if{|x| x.blank?}
      segments.join('/')
    end

    def jekyll_config
      @@jekyll_config ||= YAML.load_file(File.join(Rails.root, "app/views/static/_config.yml")) rescue {}
    end

  end
end