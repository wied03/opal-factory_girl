fg_filter 'activesupport_instrumentation' do
  # SecureRandom
  filter /using ActiveSupport::Instrumentation.*/
end
