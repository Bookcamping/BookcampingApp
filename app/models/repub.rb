class Repub < ActiveRecord::Base
  belongs_to :reference, touch: true
  delegate :title, to: :reference, prefix: true

  validates_presence_of :reference_id, :content_type, :body

  has_paper_trail meta: {
    title: :reference_title
  }

  after_create do
    reference.update_attribute(:repubbed, true)
  end

  after_destroy do
    reference.update_attribute(:repubbed, false)
  end

end
