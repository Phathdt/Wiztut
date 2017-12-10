Faker::Config.locale = :vi

User.create(email: "admin@gmail.com", password: "123456", password_confirmation: "123456", admin: true)
User.create(email: "teacher@gmail.com", password: "123456", password_confirmation: "123456", teacher: true)
User.create(email: "student@gmail.com", password: "123456", password_confirmation: "123456")

ActiveRecord::Base.transaction do
  99.times do
    password = Faker::Internet.password
    User.create(email: Faker::Internet.email , password: password, password_confirmation: password)
  end
end

ActiveRecord::Base.transaction do
  100.times do |i|
    params = {
      name: Faker::Name.name, dob: Faker::Date.birthday , sex: rand(2) + 1 ,
      school:"UIT" , degree: rand(4) + 1, graduation_year: 1990 + rand(27),
      salary: (rand 2000 + 1000 ) * 1000, grades: "{#{rand(12)+ 1}}", subjects: "{#{rand(8) + 1}}",
      about_me: Faker::StarWars.quote, phone: Faker::PhoneNumber.phone_number.to_s
    }
    User.find(i+1).build_profile(params).save
  end
end

lophoc = [
  "Cần giáo viên dạy giỏi", "Lớp học toàn học sinh khó khăn",
  "Giáo viên chăm chỉ , học sinh tích cực", "tìm gia sư cho con trai",
  "con gái chúng tôi cùng người dạy", "việc nhẹ lương cao"
]

cps = []
1000.times do
  params = {
    title: lophoc.sample, grade: rand(12) + 1, subject: rand(8) + 1, time: rand(6) + 1,
    address: rand(21) + 1, real_address: Faker::Address.street_address, salary: (rand 2000 + 1000 ) * 1000,
    sex_require: rand(3) , degree_require: rand(5) , note: Faker::StarWars.quote, user_id: rand(100) +1, phone: Faker::PhoneNumber.phone_number, frequency: rand(5) + 1
  }
  cps << CoursePost.new(params)
end

CoursePost.import cps

teacher = [
  "có 20 năm kinh nghiệm giảng dạy", "nhiều học sinh đạt thành tích cao",
  "chuyên dạy các em ngu lâu khó đào tạo", "giảng dạy là niềm vui của chúng tôi",
  "dạy con em các anh chị tốt hơn", "giúp các em vượt khó học tập", "sinh viên khó khăn đi dạy thêm",
  "dạy học thật tốt", "chuyên đi dạy thêm", "học sinh toàn giỏi"
]

tps = []
1000.times do
  params = {
    title: teacher.sample ,grade: rand(12) + 1, subject: rand(8) + 1, time: "{#{rand(6) + 1}}",
    address: "{#{rand(21) + 1}}", salary: (rand 2000 + 1000 ) * 1000 , note: Faker::StarWars.quote, user_id: rand(100) +1
  }
  tps << TeacherPost.new(params)
end

TeacherPost.import tps


coures = []
10000.times do
  coures << Course.new(teacher_id: rand(100) + 1, student_id: rand(100) + 1)
end

Course.import coures

comments = [
  "giáo viên dạy giỏi lắm các bạn ơi :D", "chưa bao giờ học tốt ntn", "đẹp trai quá",
  "chỉ nhìn giáo viên không thèm học luôn ahihi", "mình học giỏi hơn nhờ thầy nè :)",
  " giáo viên này dạy tốt mà rẻ nữa :D ", "các bạn muốn giỏi như mình ko nè",
  "mình học thầy mà đi thi học sinh giỏi luôn á", "mình học thêm môn toán mà đi thi môn văn 10 điểm nè"
]
ratings = []

User.all.each do |user|
  user.courses_as_students.each do |c|
    ratings << Rating.new(
      rater_id: c.student_id, rated_id: c.teacher_id, rate: rand(5) + 1 ,
      comment: comments.sample
    )
  end
end

Rating.import ratings

conversations = []

1000.times do
  conversations << Conversation.new(sender_id: rand(100) + 1, recipient_id: rand(100) + 1)
end

Conversation.import conversations

message = [
  "Chào thầy, thầy có khỏe không", "khỏe lắm em ơi", "em muốn gì", "em muốn thầy dạy cho em học ạ",
  "ok pede", "em học môn nào?", "môn thể dục thầy ơi", "thầy đâu có dạy thể dục đâu",
  "vậy môn gì cũng được", "ok vậy môn tiếng anh ha", "em muốn học môn Toán thầy ơi",
  "vậy em đăng ký đi lớp đi", "ok thầy"
]

messages = []

Conversation.all.each do |c|
  users = [c.sender_id, c.recipient_id]
  rand(10).times do
    messages << Message.new(body: message.sample, conversation_id: c.id, user_id: users.sample)
  end
end

Message.import messages

