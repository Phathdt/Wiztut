User.create(email: "Ps@gma.com" , password: "123123", password_confirmation: "123123")
params = { dob: Date.current , sex: 0 , school:"UIT" , degree: 0, graduation_year: 2018, salary: 1000, grades: [1], subjects: ["Toan"], about_me: "lorem isbum la bum", phone: "0945804675"}
User.first.build_profile(params).save
