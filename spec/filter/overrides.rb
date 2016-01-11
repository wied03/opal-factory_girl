fg_filter 'overrides' do
  # expecting nil but getting false due to some Opal issue. Ideally we dynamically patch the specs (like opal-rspec) to be_falsey
  filter /attribute overrides.*should be nil/
end
