module UserHelper
  def twitter_link(user)
    twitter = user.twitter.gsub(/@/,'')
    link_to "@#{twitter}", "http://twitter.com/#{twitter}", target: '_blank'
  end

  def avatar_img(user, s = 20)
    if user.avatar?
      src = case s
            when 20
              user.avatar.mini.url
            when 40
              user.avatar.small.url
            else
              user.avatar.url
            end
      image_tag src, alt: user.name, class: "avatar size#{s}", 
        width: s, height: s
    else
      old_avatar_img(user, s)
    end
  end

  def old_avatar_img(user, s = 20) 
    raw "<img src='#{gravatar_url(user, s)}' alt='#{user.name}' class='avatar size#{s}' width='#{s}' height='#{s}' />"
  end

  def gravatar_url(user, s = 20)
    default_url = path_to_image("http://bookcamping.org/images/avatar#{s}.png")
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{s}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end
end
