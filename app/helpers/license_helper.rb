module LicenseHelper

  def license_icon_tag(license)
    image_tag(license.icon.gsub(/^\//,''), alt: license.name)
    #h.raw "<img src='#{license.icon}' alt='#{license.name}'>"
  end
end