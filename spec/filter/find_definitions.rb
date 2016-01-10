fg_filter 'find_definitions' do
  # Don't do file operations in opal
  filter /definition loading.*/
end
