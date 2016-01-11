fg_filter 'attributes_from_instance' do
  # Something wrong here with our ActiveRecord mimic
  filter 'calling methods on the model instance without the attribute being overridden returns the correct value from the instance'
end
