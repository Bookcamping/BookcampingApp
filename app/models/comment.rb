class Comment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :library
  belongs_to :user

  after_create :update_comments_count
  after_destroy :update_comments_count

  has_paper_trail meta: {
      title: Proc.new { |comment| comment.resource.title }
  }

  validates_presence_of :resource_id, :resource_type, :body, :library_id

  protected
  def update_comments_count
    if self.resource.respond_to?(:comments_count)
      PaperTrail.enabled = false
      self.resource.update_attribute(:comments_count, self.resource.comments.count)
      PaperTrail.enabled = true
    end
  end
end
