namespace :db do
  desc "TODO"
  task make_data: [:create_admin, :create_users, :create_tags, :create_work_spaces,
    :create_topics, :create_posts, :create_answers,
    :create_relationships, :create_clips,
    :create_topices_users, :create_users_work_spaces] do
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
      name: "User Hidden",
      email: "user12211332244564324632@framgia.com",
      position: "Member",
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

    User.create!(
      name: "Le Thi Hong Thuy",
      email: "le.thi.hong.thuy@framgia.com",
      position: "BO",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
    )

    User.create!(
      name: "Pham Thanh Luan",
      email: "pham.thanh.luan@framgia.com",
      position: "Member",
      code: Faker::Code.asin,
      password: "Aa@123",
      password_confirmation: "Aa@123"
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
      name: "Đà Nẵng Office",
      area: "Da Nang City",
      description: "Framgia Da Nang"
    )

    WorkSpace.create!(
      name: "Hà Nội Office",
      area: "Ho Chi Minh City",
      description: "Framgia Ho Chi Minh"
    )

    WorkSpace.create!(
      name: "HCMC Office",
      area: "Ha Noi capital",
      description: "Framgia Ha Noi"
    )

    WorkSpace.create!(
      name: "TKC Office",
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
      user_id: 3,
      topic_id: 2,
      work_space_id: 3,
      content: "Ghế quá cao so với mặt sàn mà bàn lại không có chổ để chân. Ngồi
      chân không chạm đất mỏi, thậm chí còn bị căng cơ và bị xuống máu sưng chân
      rất khó chịu"
    )

    Post.create!(
      title: "Bằng khen cá nhân",
      user_id: 2,
      topic_id: 2,
      work_space_id: 3,
      content: "Bằng khen cho những cá nhân nhận được các giải thưởng hàng tháng
      của công ty, phần tên người nhận giải được viết tay nhưng vấn đề là chữ
      viết tay nhìn hơi trẻ con, trông không được trang trọng lắm. Dù sao thì
      cũng là giấy khen, nếu không viết tay thật đẹp (chữ viết hoa,
      nét đậm nhạt....) thì tốt nhất là in tên lên giấy, chứ viết tay như hiện
      giờ nhìn giảm giá trị của bằng khen lắm."
    )

    Post.create!(
      title: "Thêm khẩu trang ý tế vào tủ thuốc",
      user_id: 3,
      topic_id: 2,
      work_space_id: 1,
      content: "Ngày trước mình nhớ công ty có khẩu trang y tế cho mọi người và
      để ở tủ thuốc dễ dàng lấy, nhưng sao bây giờ mình k thấy khẩu trang để lấy
      nữa ạ? tủ thuốc cũng mất tiêu rồi ạ. Công ty có thể để khẩu trang y tế
      ra chỗ dễ nhìn hơn được k ạ? (bow)"
    )

    Post.create!(
      title: "Radio confesstion",
      user_id: 3,
      topic_id: 2,
      work_space_id: 3,
      content: "Chương trình radio confession rất hay, nhưng có những lúc ngày
      cuối tháng rơi vào giữa tuần làm mọi người không nghe được do bận làm
        việc. Vì vậy đề nghị ban phát thanh nghiên cứu sắp xếp lịch vào NGÀY
        THỨ 6 CUỐI CÙNG TRONG THÁNG thì sẽ hợp lý hơn."
    )

    Post.create!(
      title: "Tìm hiểu về quy trình review bài báo khoa học",
      user_id: 3,
      topic_id: 1,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Mình muốn tìm hiểu về quy trình review một bài báo khoa học ra sao.
      Có những tiêu chí nào để được chấp nhận publish trên hội nghị"
    )

    Post.create!(
      title: "Làm sao test R.E.S.T",
      user_id: 4,
      topic_id: 1,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Chào mọi người mình là mem mới. Mình đang chuẩn bị cho việc test 1 dự án thông qua Webservice (R.E.S.T).
      Mình thì không có kinh nghiệm test API. Nên nhờ mọi người giới thiệu giúp mình tool test cho R.E.S.T và cách dùng tool đó thế nào luôn ạ.

      Cảm ơn mọi người.
      Chúc 1 ngày tốt lành."
    )

    Post.create!(
      title: "Responsive web",
      user_id: 4,
      topic_id: 1,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Mọi người cho mình hỏi kinh nghiệm để code web reponsive theo hướng mobile-first. Mình cảm ơn."
    )

    Post.create!(
      title: "Web developer intern/fresher",
      user_id: 1,
      topic_id: 3,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Em chào các anh chị. Hiện e đang năm 3 r, e thấy trên web mình có tuyền Web developer intern/fresher.
      Vậy yêu cầu để ứng tuyển vào vị trí đó là gì ạ, hay yêu cầu về kiến thức như thế nào ạ.
      Bởi vì trong lương lai không gần thì xa là em có ý định muốn được làm việc ở Framgia :3. Em cám ơn ạ"
    )

    Post.create!(
      title: "Phạm Gia",
      user_id: 1,
      topic_id: 3,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Mình làm ở Phạm Gia cũng đc hơn năm rồi, anh em trong công ty thực sự rất vui vẻ, đoàn kết.
      Nhưng mình có cảm giác như rất nhiều người đang tự thoả mãn với chính mình.
      Nghĩ nền tảng kỹ thuật (mình không bàn tới kỹ năng quản lý) mà mình đang có là đủ để giải quyết mọi vấn đề trong công việc,
      và thế là ngừng học, ngừng code, chơi game, xem phim trong giờ... Có vẻ do làm out source lâu quá rồi,
      làm nhiều cái dễ quá nên tự thoả mãn. Khi có vấn đề thì đưa ra giải pháp nhưng lại quá tù, góp ý thì không muốn nghe (okay).
      Mình là 1 kỹ sư thì cứ học, cứ code nhiều là ấm vào thân, ngừng học 1 ngày là tụt lại đi hàng ngàn năm với công nghệ mới.
      Học từ sách vở, học từ bạn bè đồng nghiệp, nhưng cái học từ đồng nghiệp đang ngày càng xa vời,
      khi những người quanh ta đang đứng trên đỉnh cao của sự thành công hay lười biếng cũng ko rõ ;)
      Hằng ngày tới công ty vẫn phải tự nhủ: Tôi ơi, đừng cuốn vào vòng xoáy ăn chơi như mấy người kia =))
      Ps: mình biết sau khi đọc stt này sẽ có nhiều cao thủ tự xưng vào chém (hihi)
      From: Trẻ trâu đi làm"
    )

    Post.create!(
      # 10
      title: "Loa tại VP Đà Nẵng",
      user_id: 1,
      topic_id: 1,
      work_space_id: 1,
      content: "Bo xem lại chất lượng loa ở vp ĐN. Loa dùng được 2 tuần đến 1 tháng lại hư."
    )

    Post.create!(
      # 11
      title: "Chơi bowling",
      user_id: 1,
      topic_id: 2,
      work_space_id: 2,
      content: "Năm ngoái Framgia HN có chương trình chơi bowling,
      mình thấy chương trình khá vui và bổ ích, gắn kết tinh thần đồng đội,
      các thành viên Framgia. Mình mong  sẽ có thêm lần thứ 2, thứ 3, ... thứ n nữa.
      Không biết công ty có dự định tổ chức chương trình này nữa không?"
    )

    Post.create!(
      # 12
      title: "Đồ uống công ty",
      user_id: 1,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Cty mình có thể mua thêm ống hút ở khu uống nước khu buzz được không ạ?
      nhiều lúc mình pha cafe nhưng không biết lấy gì để khuấy."
    )

     Post.create!(
      # 13
      title: "Di chuyển lên/xuống văn phòng",
      user_id: 1,
      topic_id: 2,
      work_space_id: 1,
      content: "Em muốn có chút ý kiến về cầu thang bộ ở văn phòng Đà Nẵng.
      Hiện tại mật độ nhân viên thuộc các công ty ở toà nhà đang tăng lên với tốc độ chóng mặt.
      Buổi sáng chờ thang máy mất quá nhiều thời gian và bị động, chưa kể đến những lúc có 1/3 thang thường xuyên không hoạt động.
      Vậy có thể nào sau thời gian các chị lao công dọn dẹp buổi sáng thì nhờ các chị ấy mở luôn cửa thang bộ được không ạ.
      Vì lí do an toàn thì có thể mở từ 7h30 trở đi chứ không cần sớm quá.
      Như vậy sẽ giúp cho khá nhiều nhân viên tiết kiệm được thời gian buổi sáng và chủ động hơn trong việc lên văn phòng của mình;
      phần nào đó cũng giúp cho các chị em,người đang ốm, mẹ bầu . . .
      có nhiều cơ hội được đi thang máy hơn mà không phải chờ đợi quá nhiều lượt ạ (bow)"
    )

    Post.create!(
      # 14
      title: "<3 Bùi Dương",
      user_id: 1,
      topic_id: 3,
      work_space_id: 3,
      content: "E muốn hỏi a Bùi Dương có người yêu chưa ạ?Để ý anh lâu lắm rồi *_*"
    )

    Post.create!(
      # 15
      title: "Cảm nắng",
      user_id: 1,
      topic_id: 3,
      work_space_id: 4,
      content: "Dạ em đang cảm nắng một em team Design and Marketing tên Phạm Thị Thu Hà ạ,
      hình như tên như thế mà em không chắc vì công ty mình toàn để tên không dấu (facepalm).
      Không hiểu sao mới gặp có 1 lần mà đã thấy thích thích rồi, xinh cũng không xinh lắm,
      đẹp cũng không đẹp lắm, nhưng cuốn hút lắm ạ.
      Có anh chị nào cho em xin info em ấy được không ạ, có link facebook thì càng tốt ạ.
      From: Một zai Intern Ruby, không có gì nổi bật và đặc biệt cho lắm. Được cái vui tính và dễ gần thôi ạ."
    )

    Post.create!(
      # 16
      title: "Thèm yêu",
      user_id: 1,
      topic_id: 3,
      work_space_id: 3,
      content: "Muốn yêu 1 e gái làm ở Framgia quá , nhưng lại ko biết e nào chưa có người yêu cơ !
      Ps : Không biết các em gái ở framgia có kiêu không nhỉ @@
      From: 1 chàng trai FA ở Framgia"
    )

    Post.create!(
      # 17
      title: "Gửi anh Nguyễn Anh Tuấn B",
      user_id: 1,
      topic_id: 3,
      work_space_id: 2,
      content: "Nguyễn Anh Tuấn B ơi, mẫu bạn gái của đằng ấy là gì thế? (nguong)
      Đằng ấy đã có người thương chưa? Tớ bị xao xuyến rồi thì phải làm sao? (khoc2)
      From: Bạn gái thầm thương trộm nhớ cậu đã lâu"
    )

    Post.create!(
      # 18
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
      # 19
      title: "Nhung khu Buzz",
      user_id: 1,
      topic_id: 3,
      work_space_id: 3,
      content: "Cho hỏi bạn Nhung cao cao xinh xinh ngồi bên Buzz có người yêu chưa vậy?
      Mấy lần gặp nhìn vào đôi mắt mà chẳng dám nhìn lại lần nữa iiii...
      Hỏi vậy thôi chứ có biết chưa có người yêu hay chưa thì cũng (haizz)
      From: Chuột lang giấu tên
      Ad: Nghe đến chuột lang dễ thương nhỉ :)"
    )

    Post.create!(
      # 20
      title: "Câu lạc bộ Tiếng Anh",
      user_id: 1,
      topic_id: 2,
      work_space_id: WorkSpace.order("RAND()").first.id,
      content: "Sao công ty không có câu lạc bộ Tiếng Anh nhỉ,
      có lần ai nói với mình là tiếng anh mọi người đều giỏi rồi nên không cần,
      nhưng thực tế mọi người có thể đều nhìn thấy trình độ tiếng anh của mọi ngừời trong những bài morning speech thực tế rất kém.
      Một công ty IT thì tiếng anh là một yếu tố quan trọng,
      mong công ty sẽ có clb tiếng anh dạy tiếng anh như clb tiếng Nhật,
      để thỏa mãn nhu cầu được phát triển tiếng anh hơn nữa của mọi người"
    )
  end

  task create_answers: :environment do
    Answer.create!(
      user_id: 5,
      post_id: 2,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Hiện tại, Công ty cũng đang thay
      đổi hình thức trao giải hàng tháng cho trang trọng và cẩn thận hơn để xứng
       đáng với tầm quan trọng của giải thưởng. Ý kiến của bạn thực sự rất hữu
       ích, đây cũng là 1 điều mà bộ phận phụ trách (IC team) cần lưu ý hơn.
       Cảm ơn ý kiến đóng góp của bạn."
    )

    Answer.create!(
      user_id: 5,
      post_id: 3,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Tủ thuốc vẫn được đặt ở góc phải
      trên mặt quầy bar tuy nhiên do kích thước hộp tủ nhỏ nên bị khuất,
        khó nhìn. Công ty đã chuyển tủ thuốc ra vị trí dễ nhìn hơn: ngay mặt
        trước của quầy bar. Bạn có thể ra khu vực này để lấy khẩu trang hoặc
        thuốc, tư trang y tế. Nếu có vấn đề gì vui lòng liên hệ nhân viên trực
        tại quầy bar."
    )

    Answer.create!(
      user_id: 5,
      post_id: 4,
      content: "Cảm ơn bạn đã đóng góp ý kiến! Lịch phát Radio Confession không
      cố định ngày thứ 6 cuối cùng của tháng. Mỗi tháng có 1 dịp lễ đặc biệt,
      ban phát thanh dựa vào đó để lên chủ đề, biên tập nội dung và phát vào
      các dịp lễ đặc biệt của tháng đó. Ban phát thanh đã quyết định chuyển giờ
       phát Radio Confession sang 12:45 thay cho nhạc báo thức buổi trưa để
       tránh ảnh hưởng đến công việc của các bạn."
    )

    Answer.create!(
      user_id: 2,
      post_id: 5,
      content: "Theo tìm hiểu của mình thì sau khi gửi bài đến hội nghị sẽ được phân chia các nhóm reviewer để review bài của mình.
      Sau khi review nhóm đó sẽ quyết định bài báo của mình có được chấp nhận hay không
      (thời gian khoảng từ 1 tháng đến 4 tháng tùy vào hội nghị). Có một vài quyết định khi review bài báo của bạn như
      Chấp nhận (A - Publish Unaltered)
      Chấp nhận với chỉnh sửa nhỏ (AQ - Minor revision)
      Chỉnh sửa lớn (RQ - Major revision)
      Từ chối ngay (R - Reject)
      Thông thường sẽ ít khi nhóm review cho A ngay từ lần đầu mà sẽ có comment để chỉnh sửa (để cho họ còn có công review :D).
      Nếu không bị Reject thì bạn sẽ phải chỉnh sửa bài báo cho phù hợp với những comment của người review hoặc có ý kiến phản hồi lại các comment của họ.
      Tiêu chí để được chấp nhận thì cũng khá là hên xui tùy vào cảm xúc của người review nhưng ít nhất thì cũng có một vai điểm cần chú ý khi viết paper kĩ thuật đó là:
      Nên viết bằng latex
      Các công thức phải chính xác
      Hình vẽ phải dễ hiểu và rõ ràng."
    )

    Answer.create!(
      user_id: 3,
      post_id: 6,
      content: "Manual test thì POSTMAN cũng tốt. Nhưng có cái tốt hơn POSTMAN 69 lần là INSOMNIA bạn nhé :)
      https://insomnia.rest/

      Một điểm khiến mình chuyển ngay từ POSTMAN sang INSOMNIA là INSOMNIA cho phép setup nhiều môi trường khác nhau.
      Ví dụ bạn có các môi trường development, staging, production với các API URL khác nhau, bạn có thể định nghĩa các URL đó với từng môi trường, lúc test môi trường nào switch sang môi trường đó.
      POSTMAN không làm được điều này, phải đổi bằng tay hoặc phải save ra nhiều câu request giống nhau."
    )

    Answer.create!(
      user_id: 3,
      post_id: 7,
      content: "Bạn có thể đọc và tham khảo từ những bài viết này nhé:
      https://developers.google.com/web/fundamentals/design-and-ui/responsive"
    )

    Answer.create!(
      user_id: 2,
      post_id: 8,
      content: "có kiến thức nền căn bản đã đc học ở trường em nhé, ngoài ra nhiệt tình hòa nhập và quẩy cùng đc với mng nữa là ok"
    )

    Answer.create!(
      user_id: 3,
      post_id: 9,
      content: "Phiến diện nhưng ko hẳn đã sai. Bạn đưa ra vài ví dụ thực tế (về code) bạn đã gặp và cách bạn góp ý xem nào"
    )

    Answer.create!(
      user_id: 5,
      post_id: 10,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Back Office đang kiểm tra tình hình hỏng hóc của loa nghiệm trọng đến đâu để tính phương án sửa chữa triệt để hoặc thay thế mới"
    )

    Answer.create!(
      user_id: 5,
      post_id: 11,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      IC team sẽ xem xét các hoạt động để kết hợp tổ chức cùng các tiệc quý của công ty."
    )

    Answer.create!(
      user_id: 5,
      post_id: 12,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Công ty sẽ bổ sung đồ khuấy đặt tại FreeSpace của văn phòng Buzz.
      Công ty sẽ chuẩn bị 2 cốc đặt tại đây, 1 cốc đựng đồ khuấy sạch,
      1 cốc có nước để khi các bạn khuấy xong sẽ đặt đồ khuấy sử dụng rồi vào đó."
    )

    Answer.create!(
      user_id: 5,
      post_id: 13,
      content: "Cảm ơn bạn đã đóng góp ý kiến!
      Cầu thang bộ của các tòa nhà cao tầng được thiết kế để đảm bảo an ninh,
      nhân viên có thể đi ra được nhưng người ngoài sẽ không vào bên trong được.
      Hiện nay văn phòng Đà Nẵng có 1 cửa cầu thang bộ để nhân viên đi ra ngoài,
      tuy nhiên, cửa cầu thang bộ này lại nằm ngay trong văn phòng Công ty, như vậy nếu mở cửa,
      người lạ cũng có thể vào mà không cần quẹt thẻ, điều này ảnh hưởng rất lớn đến Security.
      Công ty cũng đã cân nhắc đến việc lắp máy quẹt thẻ tại cửa cầu thang bộ, tuy nhiên đây là diện tích của tòa nhà,
      Công ty không thể can thiệp. Để đảm bảo an ninh, hiện tại Công ty không thể mở cửa cầu thang bộ được.
      Các bạn hãy cố gắng đi sớm hơn để tránh tắc thang máy nhé."
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

  task create_users_work_spaces: :environment do
    UsersWorkSpace.create!(
      user_id: 4,
      work_space_id: 2,
    )
  end
end
