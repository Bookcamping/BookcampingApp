# encoding: utf-8
class Search
  attr_reader :term, :error

  def initialize(term)
    if term.present? && term.length > 2
      @term = term
      @error = nil
    else
      @term = nil
      @error = 'too_short'
    end
  end

  def search_term
    @search_term ||= term
  end

  def term?
    @term.present?
  end

  def references
    term? ? Reference.search_by_title_or_authors_or_editor(search_term, search_term, search_term) : Reference.where("1 = 0")
  end

  def shelves
    term? ? Shelf.search_by_name(search_term) : Shelf.where("1 = 0")
  end

  def tags
    term? ? Tag.search_by_name(search_term) : Tag.where("1 = 0")
  end
end

