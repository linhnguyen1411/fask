class Supports::PostSupport
  attr_reader :post

  def initialize post, id, type_input, all, page
    @post = post
    @id = id
    @type_input = type_input
    @all = all
    @page = page
  end

  def recent_posts
    get_post_by_topic(@id, @type_input, Settings.topic.type_sort.recently, @all, @page)
  end

  def popular_posts
    get_post_by_topic(@id, @type_input, Settings.topic.type_sort.popular, @all, @page)
  end

  def recently_answer_of_post
    get_post_by_topic(@id, @type_input, Settings.topic.type_sort.recently_answer, @all, @page)
  end

  def posts_no_answer
    get_post_by_topic(@id, @type_input, Settings.topic.type_sort.no_answer, @all, @page)
  end

  private
  def get_post_by_topic topic_id, type_input, type, all, page
    if all && type_input == type
      @post.send(type).get_post_by_topic(topic_id).page page
    else
      @post.send(type).get_post_by_topic(topic_id).limit Settings.paginate_default
    end
  end
end
