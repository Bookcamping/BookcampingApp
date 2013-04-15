module HasTags
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :tagged, dependent: :destroy
    has_many :tags, through: :taggings
  end

  def add_tag(tag_name)
    tag = Tag.find_tag tag_name
    tag ||= Tag.create! name: tag_name
    tagging = self.taggings.where(tag_id: tag.id).first
    tagging ||= Tagging.create!(tagged: self, tag: tag)
  end
end
