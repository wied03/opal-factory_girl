fg_filter 'traits' do
  # string mutation
  filter /traits with callbacks.*/
  filter /traits added via strategy.*/

  # ActiveRecord associations
  filter 'applying inline traits applies traits only to the instance generated for that call'
end
