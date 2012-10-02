class Search::References < Search::Base
  def self.search(term)
    self.new(order: nil, direction: :asc,
             limit: 30, term: term, search: true)
  end

  def initialize(options = {})
    super(options)
  end

  def references
    @references ||= apply_options(Reference.scoped)
  end
end
