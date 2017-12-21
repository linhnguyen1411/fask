namespace :db do
  desc "TODO"
  task make_data: [:create_work_spaces, :create_admin, :create_users,
    :create_tags, :create_topics, :create_posts, :create_answers,
    :create_relationships, :create_clips,
    :create_topices_users] do
  end

  task create_category: :environment do
    Category.create!(
      name: "Thông tin và hướng dẫn"
    )
    Category.create!(
      name: "Câu hỏi về công đoàn"
    )
    Category.create!(
      name: "Free Space"
    )
    Category.create!(
      name: "Văn minh công sở"
    )
    Category.create!(
      name: "Lương & quy định lương"
    )
    Category.create!(
      name: "WSM"
    )
    Category.create!(
      name: "Khám bệnh & Bảo hiểm"
    )
    Category.create!(
      name: "Thuế"
    )
    Category.create!(
      name: "Chính sách thâm niên"
    )
    Category.create!(
      name: "Tool sử dụng trong công việc"
    )
    Category.create!(
      name: "Câu hỏi và đóng góp về sự kiện nội bộ"
    )
    Category.create!(
      name: "Giới thiệu nhân sự"
    )
    Category.create!(
      name: "Khác"
    )
  end

  task create_admin: :environment do
      Admin.create!(
      name: "Admin",
      email: "fask.info@gmail.com",
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )
  end

  task create_users: :environment do
    User.create!(
      name: "Anonymous",
      email: "user12211332244564324632@framgia.com",
      position: "Member",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id,
      avatar: File.open(File.join(Rails.root,"app/assets/images/anonymous.png"))
    )

    User.create!(
      name: "Hoang Nhac Trung",
      email: "hoang.nhac.trung@framgia.com",
      position: "Section Manager",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Tran Duc Quoc",
      email: "tran.duc.quoc@framgia.com",
      position: "Trainer",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )
    User.create!(
      name: "Nguyen Phan Hoang Linh",
      email: "nguyen.phan.hoang.linh@framgia.com",
      position: "Member",
      code: Faker::Code.asin,
      password: "123123",
      password_confirmation: "123123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Pham Thanh Luan",
      email: "pham.thanh.luan@framgia.com",
      position: "Member",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Le Thi Hong Thuy",
      email: "le.thi.hong.thuy@framgia.com",
      position: "Hr administrator",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Nguyen Thi Minh Ngoc",
      email: "nguyen.thi.minh.ngoc@framgia.com",
      position: "Hr administrator",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Nguyen Thi Uoc Mo",
      email: "nguyen.thi.uoc.mo@framgia.com",
      position: "Group Leader (Non-Tech)",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

    User.create!(
      name: "Tran Thi Kim Ngan",
      email: "tran.thi.kim.ngan@framgia.com",
      position: "Event Officer",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123",
      work_space_id: WorkSpace.first.id
    )

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
      name: "Da Nang Office",
      area: "Da Nang City",
      description: "Framgia Da Nang"
    )

    WorkSpace.create!(
      name: "Hanoi Office",
      area: "Ho Chi Minh City",
      description: "Framgia Ho Chi Minh"
    )

    WorkSpace.create!(
      name: "HCMC Office",
      area: "Ha Noi capital",
      description: "Framgia Ha Noi"
    )

    WorkSpace.create!(
      name: "Tran Khat Chan",
      area: "Ha Noi capital",
      description: "Framgia Ha Noi"
    )

    WorkSpace.create!(
      name: "Handico Office",
      area: "Ha Noi capital",
      description: "Framgia Ha Noi"
    )
  end

  task create_topics: :environment do
    Topic.create!(
      name: "Knowledge Q&A"
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
      title: "Góp ý vê hệ thống Redmine",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Hiện nay hệ thống redmine chỉ lưu 1 người được assign gây khó khăn cho người quản lý.
      Ví dụ: sau khi dev hoàn thành ticket, sẽ gán lại cho reviewer và bị mất người dev ban đầu (chỉ lưu trong history).
      khi reviewer muốn comment lại assign cho dev thì phải tìm trong history để gán lại.
      Cách làm này tạm thời cũng vẫn chạy, nhưng tôi biết là redmine có thể cấu hình lại để thêm vào các position cho rõ ràng,
      ví dụ: các vai trò: developer, reviewer của một ticket nên được lưu tách biệt để dễ dàng quản lý và theo dõi.
      (Tại mỗi thời điểm thì tất nhiên chỉ có một assignee). Công ty có thể cấu hình lại redmine cho rõ ràng các role để tiện lợi hơn không?"
    )

    Post.create!(
      title: "Morning Speech",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "mình thấy có khá nhiều những bài speech hay. sao công ty không ghi âm lại những bài speech của mọi người rồi up lên viblo hoặc 1 cái gì đó
      Vừa tôn trọng người trình bày, vừa giúp những ai không có điều kiện nghe (tầng 18, đến muộn, bên buzz...) có thể nghe lại"
    )

    Post.create!(
      title: "Góp ý Nhà vệ sinh/Toilet",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Mình có thể yêu cầu tòa nhà cho vài cái biển báo hỏng treo trước của phòng toilet được không?
      Để người nào đi VS xong nếu cầu hỏng còn biết để thông báo cho người khác với.
      Em vừa gặp trường hợp mở nắp VS và thấy ..... nhìn tởm. em cảm ơn."
    )

    Post.create!(
      title: "Góp ý khăn lau bàn làm việc",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Các cô lau bàn làm việc bằng khăn quá cũ hay sao ấy, lông của khăn lau dính lại rất nhiều trên bàn làm việc,
      nhìn bẩn kinh khủng ấy, nhiều khi mình k để ý để tay lên còn bị ngứa mẩn đỏ cả 2 tay, rất khó chịu.
      Cá nhân mình nghĩ thà không lau còn hơn, lau lại thấy bẩn hơn.
      Mình góp ý công ty nên thay khăn lau mới cho các cô lao công ạ, hoặc là không lau nữa (haiz)"
    )

    Post.create!(
      title: "Góp ý Cốc uống nước",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Công ty mình có thể thay cốc nhựa bằng cốc giấy để bảo vệ môi trường vs sức khỏe đc ko?"
    )

    Post.create!(
      title: "Góp ý Nhà vệ sinh nam",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Có rất nhiều người ý kiến nhưng dường như k đc để ý đến. Nhà vệ sinh nam xuống cấp.
      Vòi nước rửa tay quá ngắn gây khó khăn cho việc rửa tay. Nhà vệ sinh cũng không có mùi thơm nữa kể cả buổi sáng.
      Rất bực mình mỗi lần đi vệ sinh. Mong công ty để ý đến góp ý của nhân viên. Đừng làm ngơ nữa"
    )

    Post.create!(
      title: "Góp ý âm lượng quá to khu xanh tím",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Là công ty IT nên việc trong giờ làm các thành viên trong dự án trao đổi với nhau là điều dễ hiểu.
      Tuy nhiên, mình thấy một vài cá nhân thường xuyên trao đổi với nhau với âm lượng quá to mà không ý thức được rằng đang làm ảnh hưởng đến những người ngồi gần,
      khiến mọi người không thể tập trung làm việc được.
      Mình không rõ team nào nhưng có một vài bạn nam ở dãy bàn thứ 2, 3 bên trái (nhìn từ free space) thuộc khu xanh tím thường xuyên nói rất to.
      Nếu có thể rất mong các bạn giảm bớt âm lượng để những người xung quanh  có thể tập trung hơn vào công việc."
    )

    Post.create!(
      title: "Góp ý về ý thức",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Bạn N div 3 (Đà Nẵng) có thể sử dụng đồ chung của công ty 1 cách có ý thức không vậy?
      Không phải mình thấy 1 lần mà nhiều lần rồi, lấy nước mà hết cũng không thay bình mới là sao vậy bạn?"
    )

    Post.create!(
      title: "Góp ý việc quote ChatWork",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Có thể quote những tin nhắn không liên quan mà bỏ đi phần list người được TO được không?
      Nhiều khi những tin nhắn TO all nhưng không liên quan cứ đi quote lại."
    )

    Post.create!(
      title: "Góp ý dùng từ cho vị trí kỹ sư cầu nối",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Về vị trí kỹ sư cầu nối, cty dùng cả BSE và BrSE.
      BSE cũng là từ viết tắt của chứng bệnh bò điên (Bovine Spongiform Encephalopathy (mad cow disease) nên cty nên xem xét chỉ dùng từ khóa BrSE với vị trí là kỹ sư cầu nối."
    )

    Post.create!(
      title: "Góp ý giới thiệu về bản thân",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Với các email giới thiệu về bản thân nên yêu cầu nhân viên mới ghi thêm là trực thuộc bộ phận nào, chi nhánh nào (HN, DN, HCM?)"
    )

    Post.create!(
      title: "Suggest lót thảm bên trong văn phòng",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Sau khi ra thăm văn phòng HN, có suggest là văn phòng Đà Nẵng cũng nên lót thảm bên trong như văn phòng HN.
      Dạo một vòng quanh văn phòng các tầng trên Vĩnh Trung Plaza thấy công ty nào cũng lót thảm trong văn phòng, nhìn rất đẹp ạ :D"
    )

    Post.create!(
      title: "Radio confesstion",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Chương trình radio confession rất hay, nhưng có những lúc ngày
      cuối tháng rơi vào giữa tuần làm mọi người không nghe được do bận làm
      việc. Vì vậy đề nghị ban phát thanh nghiên cứu sắp xếp lịch vào NGÀY
      THỨ 6 CUỐI CÙNG TRONG THÁNG thì sẽ hợp lý hơn."
    )

    Post.create!(
      title: "Ăn sáng ở công ty",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Cảm ơn Công ty đã trả lời ý kiến của mình.
      Như vậy nếu mình ăn sau 7h45, ngồi ở FS, ý thức là đến giờ làm việc rồi nên sẽ ăn trong 5-10ph thôi và k gây ồn ảnh hưởng xung quanh, thì có được phép k?
      Mình muốn câu trả lời rõ ràng chứ k vòng vo là Công ty k hạn chế nhưng mọi người nên sắp xếp... Bởi vì không sắp xếp được ăn sáng trước đó (con nhỏ đi học sớm, sáng lỡ dậy trễ, trời mưa...hoặc đồng nghiệp muốn ăn cùng nhau) chứ k cố ý.
      Nên mình muốn câu trả lời là có được phép hay k, nếu k thì để anh em biết tránh luôn. Còn cho phép thì để mọi người thoải mái, chứ k phải như giờ ăn 5ph thôi mà nhìn trước ngó sau, hồi hộp lỡ leader hay mana đi qua bắt gặp rồi đánh giá!"
    )

    Post.create!(
      title: "Góp ý gửi mail",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Vui lòng tạo group mail HN, các thông báo cho HN cũng mail về cho những người cần."
    )


    Post.create!(
      title: "Làm sao test R.E.S.T",
      user_id: 4,
      topic_id: 1,
      work_space_id: 1,
      content: "Chào mọi người mình là mem mới. Mình đang chuẩn bị cho việc test 1 dự án thông qua Webservice (R.E.S.T).
      Mình thì không có kinh nghiệm test API. Nên nhờ mọi người giới thiệu giúp mình tool test cho R.E.S.T và cách dùng tool đó thế nào luôn ạ.
      Cảm ơn mọi người.
      Chúc 1 ngày tốt lành."
    )

    Post.create!(
      title: "Responsive web",
      user_id: 4,
      topic_id: 1,
      work_space_id: 1,
      content: "Mọi người cho mình hỏi kinh nghiệm để code web reponsive theo hướng mobile-first. Mình cảm ơn."
    )

    Post.create!(
      title: "<3 Bùi Dương",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "E muốn hỏi a Bùi Dương có người yêu chưa ạ?Để ý anh lâu lắm rồi *_*"
    )

    Post.create!(
      title: "Cảm nắng",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "Dạ em đang cảm nắng một em team Design and Marketing tên Phạm Thị Thu Hà ạ,
      hình như tên như thế mà em không chắc vì công ty mình toàn để tên không dấu (facepalm).
      Không hiểu sao mới gặp có 1 lần mà đã thấy thích thích rồi, xinh cũng không xinh lắm,
      đẹp cũng không đẹp lắm, nhưng cuốn hút lắm ạ.
      Có anh chị nào cho em xin info em ấy được không ạ, có link facebook thì càng tốt ạ.
      From: Một zai Intern Ruby, không có gì nổi bật và đặc biệt cho lắm. Được cái vui tính và dễ gần thôi ạ."
    )

    Post.create!(
      title: "Muốn yêu 1 e gái làm ở Framgia",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "Muốn yêu 1 e gái làm ở Framgia quá , nhưng lại ko biết e nào chưa có người yêu cơ !
      Ps : Không biết các em gái ở framgia có kiêu không nhỉ @@
      From: 1 chàng trai FA ở Framgia"
    )

    Post.create!(
      title: "Gửi anh Nguyễn Anh Tuấn B",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "Nguyễn Anh Tuấn B ơi, mẫu bạn gái của đằng ấy là gì thế? (nguong)
      Đằng ấy đã có người thương chưa? Tớ bị xao xuyến rồi thì phải làm sao? (khoc2)
      From: Bạn gái thầm thương trộm nhớ cậu đã lâu"
    )

    Post.create!(
      title: "Sum Up The Remix",
      user_id: 1,
      topic_id: 3,
      work_space_id: 1,
      content: "Văn nghệ Sum Up là một chương trình hay nhất đợt nghỉ vừa rồi.
      Đội Galaxy gì đó thật ấn tượng, tuy nhiên mình thấy các bạn nữ hát hơi kém đội High.
      Đội nam bên Galaxy thì siêu ổn, đặc biệt bạn quần rách đzai.
      Đạo cụ sân khấu đẹp, nhảy đẹp, nhất là phải. Đội CH quá ko liên quan.
      Đà Nẵng đáng yêu lần sau sẽ hay hơn nữa. Tóm lại là mê Sum Up The Remix.
      From: Đà Nẵng Framgiaer"
    )

    Post.create!(
      title: "Nhung khu Buzz",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "Cho hỏi bạn Nhung cao cao xinh xinh ngồi bên Buzz có người yêu chưa vậy?
      Mấy lần gặp nhìn vào đôi mắt mà chẳng dám nhìn lại lần nữa iiii...
      Hỏi vậy thôi chứ có biết chưa có người yêu hay chưa thì cũng (haizz)
      From: Chuột lang giấu tên
      Ad: Nghe đến chuột lang dễ thương nhỉ :)"
    )

    Post.create!(
      title: "Gửi bạn lisu",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "cho hỏi bạn lisu có người yêu chưa ạ? cứ bị thấy bạn ý dễ thương ý ạ"
    )

  end

  task create_answers: :environment do
    Answer.create!(
      user_id: 6,
      post_id: 1,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Trong tất cả các hệ thống quản lý công việc, dự án (không chỉ riêng redmine),
      việc assign ticket hiện tại chỉ assign cho 1 member cụ thể nào đó trong project,
      còn việc sử dụng position để hệ thống tự động gán cho member thì hiện tại chưa có.
      Nếu có thể điều chỉnh chức năng như bạn chia sẻ, nhờ bạn trao đổi trực tiếp phương án với GL của mình để GL đó có thể chia sẻ lại
      với các GL và MN khác nhé, vì nếu có thể xử lý được việc tự động gán member như vậy thì sẽ rất hữu ích cho việc quản lý chung"
    )

    Answer.create!(
      user_id: 7,
      post_id: 2,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Hiện tại, IC team cũng đang lên kế hoạch để thay đổi format của chương trình Morning Speech,
      theo đó, phần bình chọn nhân viên có bài nói hay nhất trong tháng sẽ được thực hiện trên toàn chi nhánh,
      nội dung các bài nói sẽ được ghi lại để phục vụ quá trình bình chọn.
      Như vậy, những bạn không có điều kiện nghe MS do ngồi tại văn phòng khác hoặc đến muộn cũng có thể tiếp cận được nội dung các bài MS trước đó."
    )

    Answer.create!(
      user_id: 5,
      post_id: 3,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Đây là một ý kiến rất hữu ích.
      BO đã chuẩn bị sẵn những tấm biển báo Nhà vệ sinh/Toilet hỏng để mọi người chủ động treo lên trước cửa phòng vệ sinhkhi cần cảnh báo cho những người sử dụng tiếp theo.
      BO sẽ gửi thông báo trên box All một lần nữa để mọi người lưu ý về vấn đề này.
      Bên cạnh đó, khi có trường hợp nhà vệ sinh hỏng xảy ra, mọi người vui lòng báo trực tiếp cho BO sớm để BO thông báo toà nhà xử lý kịp thời nhé."
    )

    Answer.create!(
      user_id: 6,
      post_id: 4,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Công ty luôn chuẩn bị khăn lau mới cho các cô tạp vụ, tuy nhiên diện tích của công ty khá rộng nên có thể việc vệ sinh của các cô vẫn sẽ xẩy ra sơ suất,
      BO sẽ nhắc nhở thêm các cô về việc này. Nếu bạn thấy bàn vẫn tiếp tục bị bẩn vì bụi khăn, bạn vui lòng liên hệ trực tiếp với bộ phận Admin
      (Ms. Vũ Tuyết Mai và Ms. Lương Thu Hằng) để các bạn ấy biết được bàn đó thuộc khu vực nào, có cơ sở kiểm tra trực tiếp và báo lại các cô tạp vụ."
    )

    Answer.create!(
      user_id: 6,
      post_id: 5,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Công ty khuyến khích các bạn tự mang cốc cá nhân của mình lên công ty sử dụng để tránh lãng phí đồng thời cũng bảo vệ môi trường.
      Cốc nhựa hiện tại chỉ sử dụng trong trường hợp bất khả kháng cần dùng ngay và dùng 1 lần.
      Để đảm bảo sức khoẻ, tiết kiệm và bảo vệ môi trường, mọi người hãy sắm cho mình 1 chiếc cốc cá nhân đặt tại Công ty nhé, các cô tạp vụ sẽ giúp mọi người vệ sinh cốc hàng ngày vào cuối giờ làm việc !"
    )

    Answer.create!(
      user_id: 6,
      post_id: 6,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Bộ phận BO cũng thường xuyên liên hệ để trao đổi với tòa nhà về các vấn đề nhà vệ sinh,
      tuy nhiên với tần số sử dụng đông như Công ty mình thì ý thức giữ gìn vệ sinh chung đóng vai trò rất quan trọng.
      Vì vậy, một mặt BO vẫn nhắc nhở tòa nhà chú ý hơn trong việc dọn dẹp, một mặt rất mong mỗi cá nhân có ý thức hơn nữa trong quá trình sử dụng nhà vệ sinh.
      Hai vẫn đề nổi bật Công ty xin được trả lời như sau:
      1. Về vòi nước rửa tay quá ngắn: đây là thiết kế chung cho tất cả các nhà vệ sinh trong tòa nhà, nên phía tòa nhà không thể thay đổi riêng cho phía Framgia được, mong bạn thông cảm.
      2. Về mùi thơm: Cũng có khi máy tỏa mùi thơm bị hết pin cần reset lại, BO đã yêu cầu tòa nhà lên kiểm tra và xử lý khu vực WC nam của công ty."
    )

    Answer.create!(
      user_id: 7,
      post_id: 7,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Đây cũng là vấn đề mà công ty đã nhắc nhở chung nhiều lần trên các phương tiện khác nhau nhưng vẫn có những trường hợp nói to gây ồn làm ảnh hưởng đến mọi người xung quanh.
      IC team sẽ cân nhắc thêm phương án để truyền thông tới mọi người lưu ý hơn về vấn đề ý thức nơi làm việc.
      Đồng thời, IC team cũng đã nhắc nhở team dự án ngồi tại khu vực này chú ý trong việc trao đổi giữa các thành viên trong team. Các bạn ấy đã rút kinh nghiệm không nói quá to để tránh làm mất tập trung mọi người ngồi gần đó.
      Đôi khi do các team say sưa bàn công việc quá mà vô tình gây ảnh hưởng đến mọi người xunh quanh, vấn đề này chúng ta  cũng có thể trực tiếp nhắc nhở lẫn nhau,
      cùng nhau nâng cao ý thức tại nơi làm việc, như vậy việc cải thiện các vấn đề trong công ty sẽ nhanh và dễ dàng hơn rất nhiều"
    )

    Answer.create!(
      user_id: 5,
      post_id: 8,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Đối với các trường hợp như vậy, bạn vui lòng nhắc nhở trực tiếp bạn ấy hoặc báo lại cho BO chi nhánh Đà Nẵng để BO nhắc nhở bạn ấy rút kinh nghiệm khi sử dụng vật dụng chung trong Công ty."
    )

    Answer.create!(
      user_id: 5,
      post_id: 9,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Các bộ phận phụ trách thường quote lại các thông báo để remind nhân viên vì sợ mọi người bị miss những thông tin.
      Các bộ phận sẽ xem xét tính quan trọng của các thông báo để thay đổi tần suất quote lại kèm với việc mention tất cả nhân viên cho phù hợp."
    )

    Answer.create!(
      user_id: 5,
      post_id: 10,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Trong cộng đồng các Công ty Công nghệ thông tin đặc biệt là các Công ty Nhật Bản,
      Cả 2 từ viết tắt BSE và BrSE đều thể hiện thuật ngữ Bridge System/Software Engineer (Kỹ sư cầu nối).
      Tuy nhiên, đúng như bạn nói, ở một lĩnh vực khác BSE lại là từ viết tắt của một thuật ngữ dễ gây hiểu lầm.
      Để tránh nhầm lẫn, Công ty sẽ xem xét việc thống nhất sử dụng duy nhất từ viết tắt duy nhất là BrSE cho vị trí Kỹ sư cầu nối."
    )

    Answer.create!(
      user_id: 5,
      post_id: 11,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Hiện tại với mỗi đợt nhân viên mới PA đều gửi mail 'Welcome new member' tới toàn bộ nhân viên công ty trong đó ghi rất rõ bộ phận công tác,
      văn phòng làm việc của nhân viên mới, bạn có thể tham khảo thông tin trong mail này.
      Đồng thời, PA cũng sẽ nhắc nhở nhân viên mới viết đầy đủ những thông tin cần thiết trong mail giới thiệu bản thân để các thành viên trong công ty nắm được rõ hơn."
    )

    Answer.create!(
      user_id: 5,
      post_id: 12,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Hiện tại, Công ty chưa có kế hoạch lót thảm trải sàn tại văn phòng Đà Nẵng do một vài lý do khách quan.
      Trong tương lai, nếu có kế hoạch nâng cấp và thay đổi nội thất văn phòng Đà Nẵng, chúng tôi sẽ lưu ý đề xuất này của bạn."
    )

    Answer.create!(
      user_id: 7,
      post_id: 13,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Lịch phát Radio Confession không
      cố định ngày thứ 6 cuối cùng của tháng. Mỗi tháng có 1 dịp lễ đặc biệt,
      ban phát thanh dựa vào đó để lên chủ đề, biên tập nội dung và phát vào
      các dịp lễ đặc biệt của tháng đó. Ban phát thanh đã quyết định chuyển giờ
      phát Radio Confession sang 12:45 thay cho nhạc báo thức buổi trưa để
      tránh ảnh hưởng đến công việc của các bạn."
    )

    Answer.create!(
      user_id: 8,
      post_id: 14,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Công ty mong muốn mọi người sắp xếp thời gian ăn sáng hợp lý để không bị ảnh hưởng đến công việc.
      Tuy nhiên nếu trong điều kiện khó khăn quá không thu xếp được thời gian ăn sáng trước giờ làm thì các bạn hoàn toàn có thể ăn sáng trong giờ với việc ý thức hơn và không gây ảnh hưởng đến mọi người xung quanh."
    )

    Answer.create!(
      user_id: 8,
      post_id: 15,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Mỗi chi nhánh đã có group mail riêng. Các bộ phận thường xuyên gửi thông báo sẽ lưu ý gửi đúng group mail của các chi nhánh."
    )

    Answer.create!(
      user_id: 3,
      post_id: 16,
      content: "Manual test thì POSTMAN cũng tốt. Nhưng có cái tốt hơn POSTMAN 69 lần là INSOMNIA bạn nhé :)
      https://insomnia.rest/

      Một điểm khiến mình chuyển ngay từ POSTMAN sang INSOMNIA là INSOMNIA cho phép setup nhiều môi trường khác nhau.
      Ví dụ bạn có các môi trường development, staging, production với các API URL khác nhau, bạn có thể định nghĩa các URL đó với từng môi trường, lúc test môi trường nào switch sang môi trường đó.
      POSTMAN không làm được điều này, phải đổi bằng tay hoặc phải save ra nhiều câu request giống nhau."
    )

    Answer.create!(
      user_id: 3,
      post_id: 17,
      content: "Bạn có thể đọc và tham khảo từ những bài viết này nhé:
      https://developers.google.com/web/fundamentals/design-and-ui/responsive"
    )

  end

  task create_relationships: :environment do
    20.times do
      followerId = User.order("RAND()").where.not(id: 1).first.id;
      Relationship.create!(
        follower_id: followerId,
        following_id: User.order("RAND()").where.not(id: followerId).first.id
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

  task create_topices_users: :environment do
    TopicesUser.create!(
      user_id: 2,
      topic_id: 2
    )

    TopicesUser.create!(
      user_id: 3,
      topic_id: 1
    )
  end
end
