# frozen_string_literal: true

module SortParameters
  extend ActiveSupport::Concern

  def sort_parameters
    (params[:sort] || '').split(',').map { |sort_condition| parse_sort(sort_condition) }
  end

  def parse_sort(sort_condition)
    parts = sort_condition.split(' ')

    raise "Invalid sort condition: #{sort_condition}" if parts.length > 2

    field, direction = parts
    raise "Sort is not allowed on #{field}" unless self.class.allowed_sort_fields.find_index(field)

    direction ||= :asc
    direction = direction.downcase.to_sym
    unless %i[asc desc].include?(direction)
      raise "Invalid sort direction #{direction}, Supported directions: asc, desc"
    end

    { field => direction }
  end

  module ClassMethods
    def allowed_sort_fields
      @allowed_sort_fields ||= []
    end

    def allow_sort(*keys)
      keys = keys.map(&:to_s)
      allowed_sort_fields.concat(keys)
    end
  end
end
