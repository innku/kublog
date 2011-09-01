Factory.define :post, :class => Kublog::Post do |f|
  f.title       'Nuevos features'
  f.body        '<p>Este mes estuvimos trabajando en nuevos features...</p>'
  f.association :user, :factory => :user
end

Factory.define :category, :class=> Kublog::Category do |f|
  f.sequence(:name) { |n| "Nuevos Features #{n}" }
end

Factory.define :user do |f|
  f.name 'Adrian Cuadros'
  f.sequence(:email) {|n| "adrian#{n}@innku.com" }
  f.password  'secret'
  f.password_confirmation  'secret'
end