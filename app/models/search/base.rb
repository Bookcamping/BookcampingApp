class Search::Base
  attr_reader :options
  attr_reader :error
  attr_reader :count

  def initialize(options = {})
    @options = options.reverse_merge order: :created_at, 
      direction: :desc, limit: 30, term: nil, search: false
    @error = nil
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

  def term
    @search_term ||= if @options[:term].blank?
                       @error = 'Escribe lo que quieres buscar'
                       @options[:term]
                     elsif @options[:term].length < 3
                       @error = 'Demasiado corto'
                       @options[:term]
                     else
                       @options[:term]
                     end
  end

  def search?
    @options[:search]
  end

  protected 
  def apply_options(sc)
    if search? 
      if term.present? && error.blank?
        sc = sc.where('title LIKE ? OR authors LIKE ?', "%#{term}%", "%#{term}%")
      else
        sc = sc.where(id: -1)
      end
    end

    # order
    sc = sc.where("#{order_by} is not null").
      reorder("#{order_by} #{direction}") if order_by

    @count = sc.count
    # pages
    sc.page(page).per(per_page)
  end
end
