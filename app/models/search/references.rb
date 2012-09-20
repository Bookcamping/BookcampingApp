class Search::References 
  def initialize(options = {})
    options.reverse_merge! order: :created_at, 
      direction: :desc, limit: 30

    @options = options
  end

  def references
    @references ||= fetch
  end

  def page
    @page ||= if @options[:page].blank?
                1
              else
                @options[:page].to_i
              end
  end

  def per_page
    @options[:limit]
  end

  def direction
    @options[:direction] == :asc ? 'ASC' : 'DESC'
  end

  protected 
  def fetch
    s = Reference.scoped
    s = s.where('created_at is not null').
      reorder("created_at #{direction}")
    s = s.page(page).per(per_page)
    s
  end

end
