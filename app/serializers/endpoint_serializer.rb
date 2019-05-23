# frozen_string_literal: true

class EndpointSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :url, :active, :last_delivery_status, :last_delivery_time, :first_failure_time

  class << self
    def record_hash(record, fieldset, params = {})
      hash = super
      hash[:type] = record.class.name.demodulize
      hash[:type] = 'HttpEndpoint' if hash[:type] == 'Endpoint'
      hash
    end
  end
end
