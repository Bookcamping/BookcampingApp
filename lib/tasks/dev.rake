namespace :dev do
  task set_users_active: :environment do
    Reference.find_each do |reference|
      reference.user.update_column(:active, true)
    end
    Shelf.find_each do |shelf|
      shelf.user.update_column(:active, true)
    end
  end
end
