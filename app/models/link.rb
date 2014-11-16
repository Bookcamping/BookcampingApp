class Link < ActiveRecord::Base
  belongs_to :reference, counter_cache: true, inverse_of: :links

  default_scope order: 'position ASC'

  acts_as_list scope: :reference_id
  validates_presence_of :reference, :description, :url

  before_save :set_metadata

  def link
    "#{description}: #{url}"
  end

  def link=(link)
    self.url = PostRank::URI.extract(link)[0]
    desc = link.split(':')[0]
    self.description = desc.strip if desc.strip != 'http' && desc.length < link.length
  end

  def domain
    @domain ||= host.split('.')[-2..-1].join('.')
  end

  def nice_mime_type?
    mime_type? && mime_type.in?(%w(.pdf .epub .jpg .png))
  end

  def set_metadata
    self.url = PostRank::URI.extract(url)[0]
    uri ||= url.blank? ? nil : URI.parse(url)
    self.host ||= uri.try(:host)
    self.mime_type = uri ? File.extname(uri.path)[0..15] : nil
  end

  def type_description
    nice_mime_type? ? 'Descargar' : I18n.t("references.downloads.#{reference.ref_type}")
  end

  def self.url_link(url, reference)
    begin
      Link.new.tap do |link|
        link.url = url
        link.set_metadata
        link.description = link.nice_mime_type? ? 'Descargar' :
          I18n.t("references.downloads.#{reference.ref_type}")
        link.reference = reference
      end
    rescue Exception => e
      logger.debug "Url link: #{e}"
      nil
    end
  end
end
