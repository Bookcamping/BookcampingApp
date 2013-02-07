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
    @search_term ||= "#{term.gsub(/[¡!&¿?]/, '')}:*"
  end

  def term?
    @term.present?
  end

  def references
    @references ||= search Reference
  end

  def shelves
    @shelves ||= search Shelf
  end

  def tags
    @tags ||= search Tag
  end

  def users
    @users ||= search User
  end

  protected
  def search(model)
    if term?
      model.search(search_term)
    else
      model.where("1 = 0")
    end
  end
end

