fg_filter 'attribute_existing_on_object' do
  # Bug of some sort, seems to be calling `Kernel#format` instead of the Website model's method
  filter /accessing methods from the instance within a dynamic attribute that is also a private method on object.*/
end
