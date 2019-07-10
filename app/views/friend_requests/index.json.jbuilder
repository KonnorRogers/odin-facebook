# frozen_string_literal: true

json.array! @unread_friend_requests do |req|
  json.id req.id
  json.sender req.user 
  json.message "#{req.user.full_name} sent you a friend request"
end
