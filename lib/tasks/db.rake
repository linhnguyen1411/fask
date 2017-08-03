namespace :db do
  desc "TODO"
  task make_data: [:create_users, :create_tags, :create_work_spaces,
    :create_topics, :create_posts, :create_answers,
    :create_relationships, :create_comments, :create_clips] do
  end
  task create_users: :environment do
    User.create!(
      name: "User Hidden",
      email: "user12211332244564324632@framgia.com",
      position: "Manager",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Hoang Nhac Trung",
      email: "hoang.nhac.trung@framgia.com",
      position: "Manager",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Tran Duc Quoc",
      email: "tran.duc.quoc@framgia.com",
      position: "Leader",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Ho Quoc Hai",
      email: "ho.quoc.hai@framgia.com",
      position: "Member",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    5.times do
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        position: "Member",
        code: Faker::Code.asin,
        password: "Aa@123",
        password_confirmation: "Aa@123"
      )
    end
  end

  task create_tags: :environment do
    Tag.create!(
      name: "Ruby",
    )

    Tag.create!(
      name: "Ruby on rails",
    )

    Tag.create!(
      name: "PHP",
    )

    Tag.create!(
      name: "Laravel",
    )

    Tag.create!(
      name: "Javascript",
    )

    Tag.create!(
      name: "IOS",
    )

    Tag.create!(
      name: "Android",
    )

    Tag.create!(
      name: "Java",
    )

    Tag.create!(
      name: ".NET",
    )
  end

  task create_work_spaces: :environment do
    WorkSpace.create!(
      name: "Da Nang",
      area: "Da Nang City",
      description: "Framgia Da Nang"
    )

    WorkSpace.create!(
      name: "Ho Chi Minh",
      area: "Ho Chi Minh City",
      description: "Framgia Ho Chi Minh"
    )

    WorkSpace.create!(
      name: "Ha Noi",
      area: "Ha Noi capital",
      description: "Framgia Ha Noi"
    )
  end

  task create_topics: :environment do
    Topic.create!(
      name: "Q-A Knowledge"
    )

    Topic.create!(
      name: "Feedback"
    )

    Topic.create!(
      name: "Confesstion"
    )
  end

  task create_posts: :environment do
    Post.create!(
      title: "Góp ý vê ghế ngồi",
      user_id: User.order("RAND()").first.id,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Ghế quá cao so với mặt sàn mà bàn lại không có chổ để chân. Ngồi
      chân không chạm đất mỏi, thậm chí còn bị căng cơ và bị xuống máu sưng chân
      rất khó chịu"
    )

    Post.create!(
      title: "Bằng khen cá nhân",
      user_id: User.order("RAND()").first.id,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Bằng khen cho những cá nhân nhận được các giải thưởng hàng tháng
      của công ty, phần tên người nhận giải được viết tay nhưng vấn đề là chữ
      viết tay nhìn hơi trẻ con, trông không được trang trọng lắm. Dù sao thì
      cũng là giấy khen, nếu không viết tay thật đẹp (chữ viết hoa,
      nét đậm nhạt....) thì tốt nhất là in tên lên giấy, chứ viết tay như hiện
      giờ nhìn giảm giá trị của bằng khen lắm."
    )

    Post.create!(
      title: "Thêm khẩu trang ý tế vào tủ thuốc",
      user_id: User.order("RAND()").first.id,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Ngày trước mình nhớ công ty có khẩu trang y tế cho mọi người và
      để ở tủ thuốc dễ dàng lấy, nhưng sao bây giờ mình k thấy khẩu trang để lấy
      nữa ạ? tủ thuốc cũng mất tiêu rồi ạ. Công ty có thể để khẩu trang y tế
      ra chỗ dễ nhìn hơn được k ạ? (bow)"
    )

    Post.create!(
      title: "Radio confesstion",
      user_id: User.order("RAND()").first.id,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Chương trình radio confession rất hay, nhưng có những lúc ngày
      cuối tháng rơi vào giữa tuần làm mọi người không nghe được do bận làm
        việc. Vì vậy đề nghị ban phát thanh nghiên cứu sắp xếp lịch vào NGÀY
        THỨ 6 CUỐI CÙNG TRONG THÁNG thì sẽ hợp lý hơn."
    )
  end

  task create_answers: :environment do
    Answer.create!(
      user_id: User.order("RAND()").first.id,
      post_id: 1,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Bàn của Công ty được trang bị
      theo kích thước và chiều cao chuẩn với môi trường làm việc. Tùy theo vóc
      dáng của người sử dụng mà có thể điều chỉnh độ cao của ghế để có tư thế
      làm việc thoải mái nhất. Ghế của Công ty là loại ghế có thể điều chỉnh độ
      cao được. Bạn có thể điều chỉnh bằng cách nâng cần gạt ở ngay dưới ghế nhé.",
    )

    Answer.create!(
      user_id: User.order("RAND()").first.id,
      post_id: 2,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Hiện tại, Công ty cũng đang thay
      đổi hình thức trao giải hàng tháng cho trang trọng và cẩn thận hơn để xứng
       đáng với tầm quan trọng của giải thưởng. Ý kiến của bạn thực sự rất hữu
       ích, đây cũng là 1 điều mà bộ phận phụ trách (IC team) cần lưu ý hơn.
       Cảm ơn ý kiến đóng góp của bạn."
    )

    Answer.create!(
      user_id: User.order("RAND()").first.id,
      post_id: 3,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Tủ thuốc vẫn được đặt ở góc phải
      trên mặt quầy bar tuy nhiên do kích thước hộp tủ nhỏ nên bị khuất,
        khó nhìn. Công ty đã chuyển tủ thuốc ra vị trí dễ nhìn hơn: ngay mặt
        trước của quầy bar. Bạn có thể ra khu vực này để lấy khẩu trang hoặc
        thuốc, tư trang y tế. Nếu có vấn đề gì vui lòng liên hệ nhân viên trực
        tại quầy bar."
    )

    Answer.create!(
      user_id: User.order("RAND()").first.id,
      post_id: 4,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Lịch phát Radio Confession không
      cố định ngày thứ 6 cuối cùng của tháng. Mỗi tháng có 1 dịp lễ đặc biệt,
      ban phát thanh dựa vào đó để lên chủ đề, biên tập nội dung và phát vào
      các dịp lễ đặc biệt của tháng đó. Ban phát thanh đã quyết định chuyển giờ
       phát Radio Confession sang 12:45 thay cho nhạc báo thức buổi trưa để
       tránh ảnh hưởng đến công việc của các bạn."
    )
  end

  task create_relationships: :environment do
    20.times do
      followerId = User.order("RAND()").first.id;
      Relationship.create!(
        follower_id: followerId,
        following_id: User.order("RAND()").where.not(id: followerId).first.id
      )
    end
  end

  task create_comments: :environment do
    20.times do
      Comment.create!(
        content: Faker::Lorem.paragraph,
        user_id: User.order("RAND()").first.id,
        post_id: Post.order("RAND()").first.id,
        answer_id: Answer.order("RAND()").first.id
      )
    end
  end

  task create_clips: :environment do
    10.times do
      Clip.create!(
        post_id: Post.order("RAND()").first.id,
        user_id: User.order("RAND()").first.id
      )
    end
  end
end
