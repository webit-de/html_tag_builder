# HtmlTagBuilder

This is yet another HTML tag builder for ruby. The code is heavily borrowed from [rails](https://github.com/rails/rails/blob/master/actionview/lib/action_view/helpers/tag_helper.rb).

### Why did I made this?

Cause I needed a tag builder to use with [cells](https://github.com/trailblazer/cells). The default rails tag builder work with SafeBuffers everywhere and escape everything that is not html_safe.
This is fine for rails, but in cells this leads to problems, cause escaping in cells is done earlier and the default escaping behaviour from rails is disabled there.
So it doesn't make sense to return SafeBuffers from every tag helper in this context.
Another problem of the rails helpers are the heavy usage of global view contexts everywhere. This makes encapsulation and reuse of the helpers harder than it should be,
cause you have to provide or fake such contexts by setting the right instance variables.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html_tag_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_tag_builder

## Usage

Now here comes the funny part.
You can do all the things that you know from your rails helpers:

```ruby
include ::HtmlTagBuilder::Helper

tag(:br) #=> '<br>'
tag('br') #=> '<br>'
tag.br #=> '<br>'

tag.br(class: 'foo') #=> '<br class="foo">'

tag.div('foo', data: { bar: :baz }) #=> '<div data-bar="baz">foo</div>'
# for your convenience you can also use content_tag
content_tag(:p, 'test') #=> <p>test</p>
```

Now how do we manage nested tags without a global buffer?

```ruby
include ::HtmlTagBuilder::Helper

tag.div do |b|
  b.text('Foo')
  b.tag.br
  b.tag.span do
    'Bar'
  end
  b << '<br>'
  b << 'Baz'
end
#=> '<div>Foo<br><span>Bar</span><br>Baz</div>'
```

In this example you see the to ways you can provide blocks to a tag method of the builder.
The block variable `b` is a special buffer with the tag method available.
If you call `b.tag.br` this means create a new `<br>`-tag and add it to the local given buffer `b`. The other way to add something is to use the `.text`-method of `b` or the `<<`-method (they are the same). If you take a block argument the return value of the block is ignored.
If you don't take a block argument like `tag.span { 'Bar' }` then the return value of the inner block is the content of the tag.

Warning: There is no escaping of the content given to the tag helpers or added to the buffer!
The stuff had to be escaped before!
The only thing that gets escaped are the attribute tags. You can turn it off by setting the option `escape_attributes: false`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/html_tag_builder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HtmlTagBuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/html_tag_builder/blob/master/CODE_OF_CONDUCT.md).
