module HtmlTagBuilder
  module Helper
    def tag(name = nil, opts = nil, open = false, *args, **options)
      if name.nil?
        tag_builder
      else
        tag_builder.tag_string(name, options.merge(open_only: open).merge(opts || {}))
      end
    end

    def content_tag(name, content = nil, opts = nil, *args, **options, &block)
      options = options.merge(opts) if opts.is_a?(Hash)
      if content.is_a?(Hash)
        content = options.merge(content)
        options = nil
      end
      tag_builder.tag_string(name, content, options, &block)
    end

    # Returns a CDATA section with the given +content+. CDATA sections
    # are used to escape blocks of text containing characters which would
    # otherwise be recognized as markup. CDATA sections begin with the string
    # <tt><![CDATA[</tt> and end with (and may not contain) the string <tt>]]></tt>.
    #
    #   cdata_section("<hello world>")
    #   # => <![CDATA[<hello world>]]>
    #
    #   cdata_section(File.read("hello_world.txt"))
    #   # => <![CDATA[<hello from a text file]]>
    #
    #   cdata_section("hello]]>world")
    #   # => <![CDATA[hello]]]]><![CDATA[>world]]>
    def cdata_section(content)
      splitted = content.to_s.gsub(/\]\]\>/, "]]]]><![CDATA[>")
      "<![CDATA[#{splitted}]]>"
    end

    private

    def tag_builder
      Builder.new
    end
  end
end
