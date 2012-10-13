class AddLibreToLicensesAndReferences < ActiveRecord::Migration
  def change
    remove_column :licenses, :open
    add_column :licenses, :license_type, :string, limit: 16
    add_column :licenses, :libre, :boolean, default: false
    add_column :references, :libre, :boolean, default: false

    License.find_each do |license|
      license.license_type = license_type_of(license)
      license.libre = license.id != 1 && license.id != 9
      license.save
    end

    Reference.find_each do |reference|
      reference.update_attribute(:libre, 
                                 reference.license.libre?)
    end
  end

  def license_type_of(license)
    case license.id
    when 1
      'unknown'
    when 8
      'pd'
    when 9
      'copyright'
    else
      'cc'
    end
  end
end
