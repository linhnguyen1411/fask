class Supports::PostSupport
  attr_reader :post

  def initialize post, topic_id, type_input, all, page
    @post = post
    @topic_id = topic_id
    @type_input = type_input
    @all = all
    @page = page
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
    @post.recently_comment.limit Settings.paginate_default
  end

  def hot_post
    @post.popular.limit Settings.paginate_default
  end

  private
  def get_post_by_topic topic_id, type_input, type, all, page
    if all && type_input == type
      @post.send(type).get_post_by_topic(topic_id).page(page).per Settings.paginate_posts
    else
      @post.send(type).get_post_by_topic(topic_id).limit Settings.paginate_default
    end
  end

  def count_posts topic_id, type
    @post.send(type).get_post_by_topic(topic_id).to_ary.size
  end
end
