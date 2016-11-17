# Seriously, enough with the double render error already.

When you render or redirect, in 99% of the cases you are _done._ Rails though stubbornly
wants you to `return` explicitly, and punishes you if you don't. Sinatra was done
with this long ago using the `halt` idiom. Frankly, I don't see any use in the
explicit returns except for creating more shitwork for the developer. So...

This module uses `throw` to bail out of any Rails controller action immediately upon calling
`#render`, `#redirect_to` or `#head`. No more `return ...` and forgetting
that `return ...`. Also works wonders with `fresh_when` and friends.

Usage is explicit. To gift all of your controllers with early-return powers, extend
your ApplicationController with the module.

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  extend EnoughWithTheDoubleRenderAlready
  
  ...
end
```

All the `DoubleRenderError`s will instantly disappear. Under the hood, the module installs
an `around_action` hook and uses `throw` to abort your controller action in place.

Beware that some controllers (especially third-party etc.) may be surprised at
your heavy-handedness, so I would limit this to the controllers you write yourself.

## Contributing to enough_with_the_double_render_already
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2016 Julik Tarkhanov. See LICENSE.txt for
further details.

