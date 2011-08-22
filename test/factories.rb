Factory.define :post, :class => Kublog::Post do |f|
  f.title   'Nuevos features'
  f.body    'Este mes estuvimos trabajando en nuevos features...'
  f.user_id 1
end

Factory.define :category :class=> Kublo::Category do |f|
  f.name 'Nuevos Features'
end