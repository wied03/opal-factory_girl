fg_filter 'sequence' do
  # Opal enumerator does not have #next
  filter 'FactoryGirl::Sequence iterating over items in an enumerator navigates to the next items until no items remain'
end
