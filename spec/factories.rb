Factory.define :post, :class => Kublog::Post do |f|
  f.title       'Nuevos features'
  f.body        '<p>Este mes estuvimos trabajando en nuevos features...</p>'
  f.association :user, :factory => :user
end

Factory.define :category, :class=> Kublog::Category do |f|
  f.sequence(:name) { |n| "#{rand(n*1000)} Nuevos Features" }
end

Factory.define :notification, :class=> Kublog::Notification  do |f|
  f.kind    'fake_kind'
  f.content 'Awesome post just published'
  f.association :post, :factory => :post
end

Factory.define :twitter_notification, :class => Kublog::Notification do |f|
  f.kind 'twitter'
  f.content 'tweet content'
  f.association :post, :factory => :post
end

Factory.define :facebook_notification, :class => Kublog::Notification do |f|
  f.kind 'facebook'
  f.content 'wall post content'
  f.association :post, :factory => :post
end

Factory.define :email_notification, :class => Kublog::Notification do |f|
  f.kind 'email'
  f.content 'email content for {{user}} with a link to the post {{link}}'
  f.association :post, :factory => :post
end

Factory.define :user_comment, :class => Kublog::Comment do |f|
  f.body 'Great stuff on the blog'
  f.association :user, :factory => :user
  f.association :post, :factory => :post
end

Factory.define :anonymous_comment, :class => Kublog::Comment do |f|
  f.body 'Great stuff on the site'
  f.author_name 'Adrian Cuadros'
  f.author_email 'adrian@innku.com'
  f.association :post, :factory => :post
end

Factory.define :user do |f|
  f.name 'Adrian Cuadros'
  f.sequence(:email) {|n| "adrian#{n}@innku.com" }
  f.password  'secret'
  f.password_confirmation  'secret'
end

Factory.define :invited_author, :class => Kublog::InvitedAuthor do |f|
  f.name 'Alberto Padilla'
  f.email "alberto@innku.com"
  f.association :post
end
