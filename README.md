# Jekylly

Jekylly allows you to use a Jekyll-style site layout, including data and posts, to manage static content in a rails app.

We've tried to remain as close to Jekyll as possible, though you use ERB instead of Liquid, and layouts are handled by Rails.

### Supported Jekyll Features

* Data files
* Posts (including in categories)
* YAML Frontmatter, including titles and layouts
* Includes (though you need to add an underscore to the filenames)

### Things we've not done properly yet

* Only supports "pretty" permalink style.
* Tests. This grew out of an off-the-cuff experiment, so.
* Loads of other things probably.

## Usage

More docs to come, but the basics are:

Gemfile:
```
gem 'jekylly', github: 'OpenAddressesUK/jekylly'
```

routes.rb
```
Rails.application.routes.draw do

  # all your other routes first

  mount Jekylly::Engine, at: "/path/to/static/content" # you can use '/' if you want
  
end
```

Assets and layouts go in the Rails app as usual. Jekyll site content goes into `app/views/static`