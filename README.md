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

### Configuration

#### With ActiveRecord

If you don't have User and Identity model classes, run
`rails g billfold:models` to create them. Otherwise, include
`Billfold::ActiveRecordUser` and `Billfold::ActiveRecordIdentity` in
them respectively. You *may* wish to define
`User#perform_additional_merge_operations!` if you need to do additional
logic during a user merge.

#### Without ActiveRecord

Include `Billfold::User` and `Billfold::Identity` in the model classes.
You'll also have do define the following methods:

 * `User.find_by_id(id)`
 * `User#merge_into!(other_user)`
 * `Identity.with_provider_and_value(provider, value)`
 * `Identity#user`
 * `Identity#update_attributes!`
 * `Identity#save!`
