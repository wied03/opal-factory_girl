fg_filter 'create' do
  # ActiveRecord #new_record? method
  filter 'a created instance should not be new record'
  filter 'a created instance assigns and saves associations'
  filter 'a created instance, specifying strategy: :build saves associations (strategy: :build only affects build, not create)'
end
