fg_filter 'FactoryGirl::Strategy::Stub' do
  # no time zone support in Opal
  filter /FactoryGirl::Strategy::Stub.*created_at/

  # also needs time zones and database support
  filter /FactoryGirl::Strategy::Stub.*attempting to connect to the database.*/
end
