module CommonViewHelpers
  module ViewHelpers

    # Use words if within the last week, otherwise use date (show year if not this year)
    def time_ago_in_words_or_date(date,options={})
      return nil unless date
      if (Time.now-date)/60/60/24 < 7
        time_ago_in_words(date) + " ago"
      else
        options[:medium] ? date.strftime("%m/%d/%y") : date.to_s(:medium)
      end
    end
  
    # Output an easily styleable key-value pair
    def info_pair(label, value)
      value = content_tag(:span, "None", :class => "blank") if value.blank?
      label = content_tag(:span, "#{label}:", :class => "label")
      content_tag(:span, [label, value].join(" "), :class => "info_pair")
    end

    # Give this helper an array, and get back a string of <li> elements. 
    # The first item gets a class of first and the last, well.. last. 
    # This makes it easier to apply CSS styles to lists, be they ordered or unordered.
    # http://zeke.tumblr.com/post/98025647/a-nice-little-view-helper-for-generating-list-items
    def convert_to_list_items(items)
      items.remove_blanks.inject([]) do |all, item|
        css = []
        css << "first" if items.first == item
        css << "last" if items.last == item
        all << content_tag(:li, item, :class => css.join(" "))
      end.join("\n")
    end

    # This works just like link_to, but with one difference..
    # If the link is to the current page, a class of 'active' is added
    def link(name, options={}, html_options={})
      link_to_unless_current(name, options, html_options) do
        html_options[:class] = (html_options[:class] || "").split(" ").push("active").join(" ")
        link_to(name, options, html_options)
      end
    end
  
    # Absolute path to an image
    def image_url(source)
      base_url + image_path(source)
    end
  
    # e.g. http://localhost:3000, or https://productionserver.com
    def base_url
      "#{request.protocol}#{request.host_with_port}"
    end

    # Generate a list of column name-value pairs for an AR object
    def list_model_columns(obj)
      items = obj.class.columns.map{ |col| info_pair(col.name, obj[col.name]) }
      content_tag(:ul, convert_to_list_items(items), :class => "model_columns")
    end

  end  
end