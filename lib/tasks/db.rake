namespace :db do
  desc "TODO"
  task make_data: [:create_user, :create_role, :create_topic, :create_topic_manage, :create_tag,
    :create_company, :create_work_space, :create_post, :create_answer] do
  end
  task create_user: :environment do
    User.create!(
      name: "Hoang Nhac Trung",
      email: "hoang.nhac.trung@framgia.com",
      role_id: 3,
      company_id: 1,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Tran Duc Quoc",
      email: "tran.duc.quoc@framgia.com",
      role_id: 2,
      company_id: 1,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Pham Thanh Luan",
      email: "pham.yhanh.luan@framgia.com",
      role_id: 1,
      company_id: 1,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )
  end

  task create_role: :environment do
    Role.create!(
      id: 1,
      name: "Member"
    )

    Role.create!(
      id: 2,
      name: "Leader"
    )

    Role.create!(
      id: 3,
      name: "Manager"
    )
  end

  task create_topic: :environment do
    Topic.create!(
      name: "Q-A Knowledge",
      description: "chuyen muc hoi dap"
    )

    Topic.create!(
      name: "Feedback",
      description: "hom thu gop y"
    )

    Topic.create!(
      name: "Confession",
      description: "chuyen muc giai tri"
    )
  end

  task create_topic_manage: :environment do
    TopicManager.create!(
      user_id: 2,
      topic_id: 1
    )

    TopicManager.create!(
      user_id: 1,
      topic_id: 2
    )

    TopicManager.create!(
      user_id: 3,
      topic_id: 3
    )
  end

  task create_tag: :environment do
    Tag.create!(
      id: 1,
      name: "Ruby"
    )

    Tag.create!(
      id: 2,
      name: "Rails"
    )
  end

  task create_company: :environment do
    Company.create!(
      name: "Framgia",
      owner_id: 1
    )
  end

  task create_work_space: :environment do
    WorkSpace.create!(
      name: "Framgia HN",
      company_id: 1
    )

    WorkSpace.create!(
      name: "Framgia DN",
      company_id: 1
    )

    WorkSpace.create!(
      name: "Framgia HCM",
      company_id: 1
    )
  end

  task create_post: :environment do
    Post.create!(
      title: "Ruby",
      content: "Ruby la gi?",
      view_counts: 100,
      status: "",
      user_id: 2,
      topic_id: 1,
      work_space_id: 1
    )

    Post.create!(
      title: "Ghế ngồi khu free space",
      content: "Khu free space hay bị hết ghế trong giờ ăn trưa,
      có thể bổ sung ghế ngồi trong khoảng thời gian ăn trưa không?",
      view_counts: 100,
      status: "done",
      user_id: 2,
      topic_id: 2,
      work_space_id: 1
    )

    Post.create!(
      title: "Tam su dem khuya",
      content: "Buon nhu con chuon chuon",
      view_counts: 100,
      status: "",
      user_id: 2,
      topic_id: 3,
      work_space_id: 1
    )
  end

  task create_answer: :environment do
    Answer.create!(
      post_id: 1,
      user_id: 1,
      content: "Ruby là một ngôn ngữ lập trình hướng đối tượng và có khả năng reflection..."
    )

    Answer.create!(
      post_id: 2,
      user_id: 1,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Công ty đã bổ sung ghế dự phòng trong trường hợp thiếu ghế tại khu Free Space vào giờ ăn trưa.
      Ghế dự phòng (màu vàng hoặc màu trắng) đang được đặt tại kho gần khu Free Space
      (từ cửa lễ tân đi vào rẽ bên phải, kho thuộc diện tích khu vực màu xanh dương).
      Các bạn vui lòng gấp gọn ghế và trả lại trong kho sau khi sử dụng xong nhé."
    )

    Answer.create!(
      post_id: 3,
      user_id: 1,
      content: "Bat gian choi de"
    )
  end

end
