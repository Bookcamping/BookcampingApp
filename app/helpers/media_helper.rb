module MediaHelper
  def render_media(reference)
    if /youtube.com\/watch\?v=([\w\s\-_]*)/.match(reference.media) or /youtu\.be\/(.*)/.match(reference.media)
      frame = "<iframe width='339' height='223' src='http://www.youtube.com/embed/#{$1}' frameborder='0' allowfullscreen></iframe>"
      link = content_tag(:div, link_to('&rArr; Ver en youtube'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /vimeo.com\/(\d+)/.match(reference.media)
      frame = '<iframe src="http://player.vimeo.com/video/' + $1 + '?title=0&amp;byline=0&amp;portrait=0" width="339" height="256" frameborder="0"></iframe>'
      link = content_tag(:div, link_to('&rArr; Ver en vimeo'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /docid=(.+)/.match(reference.media)
      frame = "<embed id=VideoPlayback src=http://video.google.com/googleplayer.swf?docid=#{$1}&hl=es&fs=true style=width:339px;height:223px allowFullScreen=true allowScriptAccess=always type=application/x-shockwave-flash> </embed>"
      link = content_tag(:div, link_to('&rArr; Ver en google video'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /^</.match(reference.media)
      reference.media.html_safe
    else
      link_to(image_tag(reference.media[0..200], class: 'cover'), reference)
    end
  end
end
