module UserHelper
  def avatar_img(user, s = 20) 
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
