json.conversations @conversations do |c|
  json.id           c.id
  json.user_name    c.opposite(@current_user.id)&.name
  json.avatar       c.opposite(@current_user.id)&.avatar&.url
  json.user_id      c.opposite(@current_user.id).user.id
  json.last_message c.messages.last
end
