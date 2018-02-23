class Supports::PostSupport
  def initialize post = nil, post_params = nil
    if post_params.present?
      post_params.each do |post_param|
        instance_variable_set "@#{post_param.first}", post_param.last
      end
    end
    @post = post
  end

  def hot_post
    Post.post_of_topic_on.popular.limit Settings.paginate_default
  end

  def answers_of_post
    Answer.answers_of_post @post.id
  end

  def view_more_time
    @view_more_time.nil? ? Time.now : @view_more_time.to_time
  end

  def comments_of_post
    Comment.comments_of_post_before_time(@post, view_more_time).
      page(@comment_page).per(Settings.paginate_comment).to_a.reverse
  end

  def next_page
    if (@comment_page.nil? &&  @post.comments.count <= Settings.paginate_comment)
      Settings.not_view_more
    elsif @comment_page.nil?
      Settings.second_page
    elsif Settings.paginate_comment * @comment_page.to_i < Comment.comments_of_post_before_time(@post, @view_more_time).count
      @comment_page.to_i + Settings.one_page
    else
      Settings.not_view_more
    end
  end

  def count_vote
    @post.reactions.upvote.size - @post.reactions.downvote.size
  end

  def clip_list
    @post.clips
  end

  def count_comment
    @post.comments.size
  end

  def count_version
    @post.a_versions.get_version_post_not_reject(@post.id, @post.class.name).size
  end

  def check_a_version_for_post
    @post.a_versions.accept.first
  end

  def tag_list
    @post.tags
  end

  def category_list
    Category.all
  end

  def work_space_list
    WorkSpace.all
  end

  def topic_list
    Topic.load_topic_on
  end

  def related_question
    return if @post.category.nil?
    @post.category.posts.not_contain_post(@post.id).newest.accept.limit Settings.paginate_default
  end
end
