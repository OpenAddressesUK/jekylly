module Jekylly
  class Page
    
    attr_accessor :path
    
    def initialize(path)
      @path = path # Path to file
    end

    def content
      content = File.read(File.expand_path("app/views/static/#{path}", Rails.root))
      content.gsub!(/---$.*?^---$/m,'')
      content
    end

    def metadata
      @metadata ||= YAML.load_file(File.expand_path("app/views/static/#{@path}", Rails.root))
    end

    def title
      metadata['title']
    end
    
  end
end