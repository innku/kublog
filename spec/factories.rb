Factory.define :post, :class => Kublog::Post do |f|
  f.title       'Nuevos features'
  f.body        '<p>Este mes estuvimos trabajando en nuevos features...</p>'
  f.association :user, :factory => :user
end

Factory.define :category, :class=> Kublog::Category do |f|
  f.sequence(:name) { |n| "#{rand(n*1000)} Nuevos Features" }
end

Factory.define :notification, :class=> Kublog::Notification  do |f|
  f.kind    'Twitter'
  f.content 'Awesome post just published'
  f.association :post, :factory => :post
end

Factory.define :user do |f|
  f.name 'Adrian Cuadros'
  f.sequence(:email) {|n| "adrian#{n}@innku.com" }
  f.password  'secret'
  f.password_confirmation  'secret'
end

