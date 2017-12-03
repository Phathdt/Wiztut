json.course_posts @cps do |c|
  json.id           c.id
  json.title        c.title
  json.address      c.address
  json.real_address c.real_address
  json.name         c.owner.name
end
