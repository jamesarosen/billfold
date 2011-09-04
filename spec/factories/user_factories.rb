Factory.sequence :user_name do |n|
  "User #{n}"
end

Factory.define :user do |user|
  user.name { Factory.next(:user_name) }
end
