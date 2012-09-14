module LicenseHelper

  def license_icon_tag(license)
    #image_tag(license.icon.gsub(/^\//,''), alt: license.name)
    raw "<img src='#{license.icon}' alt='#{license.name}'>"
  end

  def license_type_icon(reference)
    name = reference.license.license_type
    image_tag("license_icons/#{name}.png", :class => 'license-type')
  end
end
