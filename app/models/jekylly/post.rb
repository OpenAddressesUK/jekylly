module Jekylly
  class Post < Jekylly::Page
    
    def url
      segments = parsed_path.to_a.slice(1,5).delete_if{|x| x.blank?}
      segments.join('/')
    end

    def author
      metadata['author']
    end

    def category
      parsed_path[1]
    end

    def date
      str = "#{parsed_path[2]}-#{parsed_path[3]}-#{parsed_path[4]}"
      Date.parse(str)
    end

    private
    
    def parsed_path
      @parsed_path ||= @path.match /(.*?)\/?_posts\/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.+?)\./
    end
    

  end
end