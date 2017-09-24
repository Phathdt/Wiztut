require 'faker'
Faker::Config.locale = :vi

ActiveRecord::Base.transaction do
  100.times do
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
    sex_require: rand(3) , degree_require: rand(5) , note: Faker::StarWars.quote, user_id: rand(100) +1
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
1000.times do
  coures << Course.new(teacher_id: rand(100) + 1, student_id: rand(100) + 1)
end

Course.import coures
