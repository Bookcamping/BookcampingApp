class Download < ActiveRecord::Base
  belongs_to :reference, counter_cache: true

  acts_as_list scope: :reference_id
  validates_presence_of :reference_id

  def host
    @host ||= uri.try(:host)
  end

  def mime_type
    @mime_type = uri ? File.extname(uri.path) : nil
  end

  protected
  def uri
    @uri ||= url.blank? ? nil : URI.parse(url)
  end
end
