# frozen_string_literal: true

json.array! @last_five_requests do |req|
  json.id req.id
  json.read req.read_at
  json.sender req.user
  json.message "#{req.user.full_name.titleize} sent you a friend request"
  json.url friend_requests_path
end
