# frozen_string_literal: true

module PaginationParameters
  extend ActiveSupport::Concern

  def next_records_parameters
    {
      limit: params[:limit],
      offset: params[:offset].to_i + params[:limit].to_i
    }
  end

  def previous_records_parameters
    offset = params[:offset].to_i if params[:offset]
    limit = params[:limit].to_i if params[:limit]
    {
      limit: offset && offset < limit ? offset : limit,
      offset: [(offset || 0) - limit, 0].max
    }
  end
end
