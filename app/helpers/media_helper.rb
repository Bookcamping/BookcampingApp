
module MediaHelper

  def render_media(reference)
    MediaRendered.new(reference.media)
  end

  class MediaRendered
    include AutoHtml
    attr_reader :html

    def initialize(media)
      if media.present?
        @html = auto_html media do
          html_escape
          image
          youtube(:width => 400, :height => 250)
          google_video
          vimeo
          flickr
          dailymotion
          soundcloud
          link :target => "_blank", :rel => "nofollow"
          simple_format
        end
      end
    end

    def iframe?
      /iframe/ =~ @html
    end
  end
end
