namespace :bookcamping do
  task activize: :environment do
    Version.find_each do |version|
      if version.item_type == 'Page' || version.item_type == 'Bookmark'
        version.destroy
      elsif version.event == 'create' && version.item.blank?
        version.destroy
      else
        Activity.activize(version)
      end
    end
  end

  task :destroy_empty_tags => :environment do
    Tag.where(taggings_count: 0).destroy_all
  end

  task :site_member, [:user_id] => [:environment] do |t, args|
    user = User.find args.user_id

    puts "User: #{user.name}"
    if user.site_member?
      puts "Remove site member"
      user.update_attribute(:site_member, false)
    else
      puts "Set site member"
      user.update_attribute(:site_member, true)
    end
  end

  task :change_reference_user, [:reference_id, :new_user_id] => [:environment] do |t, args|
    p args
    reference = Reference.find args.reference_id
    old_user = reference.user
    user = User.find args.new_user_id

    ActiveRecord::Base.record_timestamps = false
    PaperTrail.without_versioning do
      reference.update_attribute(:user_id, user.id)
      Version.where(item_type: 'Reference', item_id: reference.id).update_all(user_id: user.id)
      ShelfItem.where(reference_id: reference.id, user_id: old_user.id).update_all(user_id: user.id)
    end
  end

  task merge_user: :environment do
    user = User.find ENV['USER']
    id = ENV['DUP']

    puts "Merge #{user.name} with #{id}"
    dup = User.find_by_id id

    if dup.present?
      user.email ||= dup.email
      user.twitter ||= dup.twitter
      user.description ||= dup.description
      user.password_digest ||= dup.password_digest
      user.uid_twitter ||= dup.uid_twitter
      user.uid_facebook ||= dup.uid_facebook
      user.uid_google ||= dup.uid_google
      Reference.where(user_id: id).update_all(user_id: user.id)
      ShelfItem.where(user_id: id).update_all(user_id: user.id)
      Shelf.where(user_id: id).update_all(user_id: user.id)
      Comment.where(user_id: id).update_all(user_id: user.id)
      Membership.where(user_id: id).update_all(user_id: user.id)
      Tagging.where(user_id: id).update_all(user_id: user.id)
      Version.where(whodunnit: id).update_all(whodunnit: user.id)

      dup.destroy
      user.save(validate: false)
      puts "#{user.name} merged!"
    else
      puts "User with id #{id} not found"
    end
  end

  task normalize_camp_shelves: :environment do
    ActiveRecord::Base.record_timestamps = false
    CampShelf.all.each do |shelf|
      shelf.group = shelf.camp.group
      shelf.open = true
      puts "Saved #{shelf.save}: #{shelf.name} (#{shelf.group_id})"
      puts "#{shelf.inspect}"
    end
  end
end
