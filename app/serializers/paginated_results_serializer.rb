# frozen_string_literal: true

class PaginatedResultsSerializer < ActiveModel::Serializer
  attributes :results, :meta

  def results
    return [] unless each_serializer

    collection.map do |item|
      each_serializer.send(:new, item)
    end
  end

  def meta
    {
      total: collection.total_count,
      total_pages: collection.total_pages,
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      first_page: collection.first_page?,
      last_page: collection.last_page?
    }
  end

  private

  def collection
    object[:collection]
  end

  def each_serializer
    object[:each_serializer]
  end
end
