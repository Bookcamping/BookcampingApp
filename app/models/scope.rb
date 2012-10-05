class Scope
  def initialize(scoped, options = {})
    @scoped = scoped
    @options = options.reverse_merge order: :created_at, 
      direction: :desc, limit: 30
  end

  def page
    @page ||= @options[:page].blank? ? 1 : @options[:page].to_i
  end

  def per_page
    @options[:limit]
  end

  def order_by
    @options[:order]
  end

  def direction
    @options[:direction] == :asc ? 'ASC' : 'DESC'
  end

  def all
    @all ||= scoped
  end

  def total_pages
    all.num_pages
  end

  def count
    @count
  end

  def scoped
    # order
    sc = @scoped.where("#{order_by} is not null").
      reorder("#{order_by} #{direction}") if order_by
    @count = sc.count
    # pages
    sc.page(page).per(per_page)
  end
end
