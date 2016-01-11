fg_filter 'build_stubbed' do
  # time zone/Opal
  filter /defaulting `created_at`.*/
  # ActiveRecord #increment method
  filter 'a generated stub instance disables increment'
end
