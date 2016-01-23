module ApplicationHelper
  
  def avatar_for(user, options = { size: "150x150"})
    size = options[:size] || "150x150"
    if user.avatar.url
      image_tag user.avatar.url, size: size, class: "img-circle"
    else
      image_tag 'http://www.femto.it/wp-content/uploads/2014/04/default-user-avatar.png', size: size, class: "img-circle"
    end
  end
  
end
