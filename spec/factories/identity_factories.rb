Factory.sequence :uid do |n|
  ( ( ( n + 13 ) ** 3 ) * 21 ) % 100000
end

Factory.sequence :twitter_handle do |n|
  "user#{n}"
end

Factory.define :identity do |id|
  id.user     { User.first || Factory(:user) }
  id.provider 'orrnge'
  id.value    { Factory.next :uid }
end

Factory.define :twitter_identity, :parent => :identity do |id|
  id.provider 'twitter'
  id.value    { Factory.next(:twitter_handle) }
end
