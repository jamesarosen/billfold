## Billfold

Billfold provides backend Rails support for OmniAuth. Specifically, it
routes `/auth/:provider/callback` to
`Billfold::AuthenticationController#update_or_create!`, which handles
identity management.

### Requirements

 * Rails 3.x

### Installation

1. Add `gem 'billfold'` to your `Gemfile`
1. Run `bundle` (or `bundle install`)
1. Run `rails g billfold:migration`
