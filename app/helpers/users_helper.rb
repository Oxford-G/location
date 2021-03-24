module UsersHelper
  def destroy
    session.delete(:current_user_id)
  end

  def avatar_thumbnail

    if photo.attached?
      photo.variant(resize: '50x50!').processed
    else
      '/default_avatar.jpg'
    end
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'default.jpg'
        )
      ), filename: 'default_avatar.jpg',
      content_type: 'image/jpg'
    )
  end
end
