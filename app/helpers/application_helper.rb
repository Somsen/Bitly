module ApplicationHelper
  def first_name(user)
    user.name.to_s.split(' ').first
  end
end
