json.conversations @conversations do |c|
  json.id c.id
  json.user_name c.opposite(@current_user.id)&.name
  json.avatar c.opposite(@current_user.id)&.avatar&.url
  json.sender_id c.sender_id
  json.recipient_id c.recipient_id
  json.last_message c.messages.last
end
