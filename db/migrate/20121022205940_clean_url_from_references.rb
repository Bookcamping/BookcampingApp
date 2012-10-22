class CleanUrlFromReferences < ActiveRecord::Migration
  def up
    Reference.destroy_all(id: [36, 157, 1408])
    Reference.find_each do |reference|
      if reference.url?
        link = reference.url_link
        if link.present?
          link.reference_id = reference.id
          link.user_id = reference.user_id
          if link.save
            reference.url = nil
            if reference.save
              print '.'
            else
              puts "F"
              puts "Reference can't be saved: #{reference.to_param}"
            end
          else
            puts "F"
            puts "Link can't be saved: #{reference.to_param}"
            p link.errors
          end
        else
          puts "F"
          puts "Link not found: #{reference.to_param}"
        end
      else
        print "S"
      end
    end
    remove_column :references, :url
  end

  def down
  end
end
