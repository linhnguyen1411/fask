class Supports::PostSupport
  attr_reader :post

  def initialize class_name, topic_id, type_input, all, page, view_more_time = nil, post = nil
    @class_name = class_name
    @topic_id = topic_id
    @type_input = type_input
    @all = all
    @page = page
    @view_more_time = view_more_time
    @post = post
  end

  def recent_posts
    posts = get_post_by_topic @topic_id, @type_input, Settings.topic.type_sort.recently, @all, @page
    count_posts = count_posts @topic_id, Settings.topic.type_sort.recently
    {posts: posts, count_posts: count_posts}
  end

  def popular_posts
    posts = get_post_by_topic @topic_id, @type_input, Settings.topic.type_sort.popular, @all, @page
    count_posts = count_posts @topic_id, Settings.topic.type_sort.popular
    {posts: posts, count_posts: count_posts}
  end

  def recently_answer_of_post
    posts = get_post_by_topic @topic_id, @type_input, Settings.topic.type_sort.recently_answer, @all, @page
    count_posts = count_posts @topic_id, Settings.topic.type_sort.recently_answer
    {posts: posts, count_posts: count_posts}
  end

  def posts_no_answer
    posts = get_post_by_topic @topic_id, @type_input, Settings.topic.type_sort.no_answer, @all, @page
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

  private
  def get_post_by_topic topic_id, type_input, type, all, page
    if all && type_input == type
      @class_name.send(type).get_post_by_topic(topic_id).page(page).per Settings.paginate_posts
    else
      @class_name.send(type).get_post_by_topic(topic_id).limit Settings.paginate_default
    end
  end

  def count_posts topic_id, type
    @class_name.send(type).get_post_by_topic(topic_id).to_ary.size
  end
end
