json.course_posts @cps do |c|
  json.id           c.id
  json.grade        c.grade
  json.title        c.title
  json.address      c.address
  json.real_address c.real_address
  json.name         c.owner.name
  json.user_id      c.owner.id
end
