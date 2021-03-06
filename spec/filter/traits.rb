fg_filter 'traits' do
  # string mutation
  filter /traits with callbacks.*/
  filter /traits added via strategy.*/

  # ActiveRecord associations
  filter 'applying inline traits applies traits only to the instance generated for that call'

  # Bug, not sure what's going on
  filter /an instance generated by a factory with multiple traits child factory created where trait attributes.*/
end
