json.array! notifications do |notification|
  json.id notification.id
  json.sender notification.sender
  json.action notification.action
  json.notifiable do
    json.type "a #{notification.notifiable_type.to_s.underscore.humanize.downcase}"
  end

  json.url notifications_path
end
