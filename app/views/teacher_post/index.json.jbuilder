json.teacher_post @tps do |t|
  json.id      t.id
  json.title   t.title
  json.address t.address
  json.name    t.owner.name
  json.avatar  t.owner.avatar.url
end
