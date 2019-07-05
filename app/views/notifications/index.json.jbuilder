# frozen_string_literal: true

json.array! @notifications do |notification|
  json.id notification.id
  json.sender notification.sender
  json.action notification.action
  json.notifiable do
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
end
