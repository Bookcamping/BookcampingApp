# encoding: utf-8

class NotifyMailerTest < ActionMailer::TestCase
  def test_shelf_created_email
    shelf = create(:shelf)
    user = create(:user)

    email = NotifyMailer.shelf_created(shelf, user).deliver
    assert_delivered_to(email, user)

    email.subject.must_equal 'Tenemos una nueva estantería'
    email.encoded.must_match /Hola #{user.name}/
  end

  def test_shelf_item_created_email
    shelf = create(:shelf)
    item = shelf.add_reference(create(:reference))
    user = create(:user)

    email = NotifyMailer.shelf_item_created(item, user).deliver
    assert_delivered_to(email, user)
  end

  def test_reference_updated
    reference = create(:reference)
    user = create(:user)

    email = NotifyMailer.reference_updated(reference, user).deliver
    assert_delivered_to(email, user)
    email.encoded.must_match reference.title
  end

  private
  def assert_delivered_to(email, user)
    !ActionMailer::Base.deliveries.wont_be :empty?
    email.to.must_equal [user.email]
  end
end
