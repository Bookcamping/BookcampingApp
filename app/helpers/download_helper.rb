module DownloadHelper
  def link_to_download(download)
    label = ''
    if download.mime_type.present?
      label = icon('download', "Descargar (#{download.mime_type})")
    else
      label = icon('eye-open', (download.description? ?
        download.description : 'Leer'))
    end

    #label += content_tag(:span, icon('external-link', download.host), class: 'host')

    link_to label, download.url
  end
end
