module HasTags
  extend ActiveSupport::Concern

  included do
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    after_save :save_tags
  end

  protected
  def save_tags
    self.taggings.destroy_all
    if self.tag_names.present?
      self.tag_names.split(',').each do |tag_name|
        add_tag(tag_name)
      end
    end
  end

  def add_tag(tag_name)
    tag = Tag.find_tag tag_name
    tag ||= Tag.create! name: tag_name
    Tagging.create!(reference: self, tag: tag)
  end

end
