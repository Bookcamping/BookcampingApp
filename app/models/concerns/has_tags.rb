module HasTags
  extend ActiveSupport::Concern

  included do
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    after_save :save_tags
  end

  protected
  def save_tags
   Tagging.where(reference_id: self.id).destroy_all
    if self.tag_names.present?
      self.tag_names.split(',').each do |tag_name|
        add_tag(tag_name)
      end
    end
    true
  end

  def add_tag(tag_name)
    tag = Tag.find_tag tag_name
    tag ||= Tag.create! name: tag_name
    Tagging.create!(reference: self, tag: tag)
  end

end
