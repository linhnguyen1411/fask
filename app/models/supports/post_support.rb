class Supports::PostSupport
  attr_reader :post

  def initialize(class_name, topic_id, type_input, all, page, view_more_time = nil,
    post = nil, work_space_id = nil, from_day = nil, to_day = nil)
    @class_name = class_name
    @topic_id = topic_id
    @type_input = type_input
    @all = all
    @page = page
    @view_more_time = view_more_time
    @post = post
    @work_space_id = work_space_id
    @from_day = from_day
    @to_day = to_day
  end

  def recent_posts
    posts = get_post_by_topic(@topic_id, @type_input, Settings.topic.type_sort.recently,
      @all, @page, @work_space_id, @from_day, @to_day)
    count_posts = count_posts @topic_id, Settings.topic.type_sort.recently
    {posts: posts, count_posts: count_posts}
  end

  def popular_posts
    posts = get_post_by_topic(@topic_id, @type_input, Settings.topic.type_sort.popular,
      @all, @page, @work_space_id, @from_day, @to_day)
    count_posts = count_posts @topic_id, Settings.topic.type_sort.popular
    {posts: posts, count_posts: count_posts}
  end

  def recently_answer_of_post
    posts = get_post_by_topic(@topic_id, @type_input, Settings.topic.type_sort.recently_answer,
      @all, @page, @work_space_id, @from_day, @to_day)
    count_posts = count_posts @topic_id, Settings.topic.type_sort.recently_answer
    {posts: posts, count_posts: count_posts}
  end

  def posts_no_answer
    posts = get_post_by_topic(@topic_id, @type_input, Settings.topic.type_sort.no_answer,
      @all, @page, @work_space_id, @from_day, @to_day)
    count_posts = count_posts @topic_id, Settings.topic.type_sort.no_answer
    {posts: posts, count_posts: count_posts}
  end

  def recent_comment_of_post
    @class_name.recently_comment.limit Settings.paginate_default
  end

  def hot_post
    @class_name.popular.limit Settings.paginate_default
  end

  def view_more_time
    @view_more_time.nil? ? Time.now : @view_more_time.to_time
  end

  def comments_of_post
    Comment.comments_of_post_before_time(@post, view_more_time).
      page(@page).per(Settings.paginate_comment).to_a.reverse
  end

  def next_page
    if (@page.nil? &&  @post.comments.count <= Settings.paginate_comment)
      Settings.not_view_more
    elsif @page.nil?
      Settings.second_page
    elsif Settings.paginate_comment * @page.to_i < Comment.comments_of_post_before_time(@post, @view_more_time).count
      @page.to_i + Settings.one_page
    else
      Settings.not_view_more
    end
  end

  def post_of_work_space type
    posts = if @all
      @class_name.send(type).post_by_topic(@topic_id).post_of_work_space(@work_space_id).post_in_time(@from_day, @to_day)
        .page(@page).per Settings.paginate_posts
    else
      @class_name.send(type).post_by_topic(@topic_id).post_of_work_space(@work_space_id).post_in_time(@from_day, @to_day)
        .limit Settings.paginate_default
    end
    count_posts = if type == Settings.topic.type_sort.no_answer
     @class_name.send(type).post_by_topic(@topic_id)
      .post_of_work_space(@work_space_id).post_in_time(@from_day, @to_day).size
    else
      @class_name.post_by_topic(@topic_id)
      .post_of_work_space(@work_space_id).post_in_time(@from_day, @to_day).size
    end
    {posts: posts, count_posts: count_posts}
  end

  def get_work_space
    if @work_space_id.present?
      WorkSpace.get_work_space(@work_space_id).first
    else
      I18n.t("all_location")
    end
  end

  def filter_time
    {from_day: @from_day, to_day: @to_day}
  end

  private
  def get_post_by_topic topic_id, type_input, type, all, page, work_space_id, from_day, to_day
    if work_space_id.present?
      if all && type_input == type
        @class_name.send(type).post_by_topic(topic_id).post_of_work_space(work_space_id).post_in_time(from_day, to_day)
          .page(page).per Settings.paginate_posts
      else
        @class_name.send(type).post_by_topic(topic_id).post_of_work_space(work_space_id)
          .limit Settings.paginate_default
      end
    else
      if all && type_input == type
        @class_name.send(type).post_by_topic(topic_id).post_in_time(from_day, to_day).page(page).per Settings.paginate_posts
      else
        @class_name.send(type).post_by_topic(topic_id).post_in_time(from_day, to_day).limit Settings.paginate_default
      end
    end
  end

  def count_posts topic_id, type
    @class_name.send(type).post_by_topic(topic_id).to_ary.size
  end
end
