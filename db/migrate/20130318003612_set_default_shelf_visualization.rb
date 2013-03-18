class SetDefaultShelfVisualization < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    set_default_shelf_visualization(:icons, [1,2,6]) 
    set_default_shelf_visualization(:list, [12, 13])
  end

  def set_default_shelf_visualization(viz, ids)
    ids.each do |lib_id|
      library = Library.find lib_id
      library.shelves.update_all(visualization: viz)
    end
  end
end
