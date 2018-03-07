class Supports::TopicSupport
  def initialize topic_params
    topic_params.each do |topic_param|
      instance_variable_set "@#{topic_param.first}", topic_param.last
    end
    @sort_type = get_sort_type(@sort_type)
  end

  def filter_posts
    Post.send(@sort_type).post_by_topic(@id).post_of_work_space(@work_space_id)
      .post_in_time(@from_day, @to_day).post_of_category(@category_id)
      .page(@page).per Settings.paginate_default
  end

  def work_space
    work_space = WorkSpace.find_by id: @work_space_id
  end

  def filter_type
    {from_day: @from_day, to_day: @to_day, sort_type: @sort_type, category_id: @category_id}
  end

  def top_users
    User.top_users.limit Settings.limit_top
  end

  def tag_list
    Tag.top_tags.limit Settings.limit_tag
  end

  def category_list
    Category.include_count_post
  end

  def work_space_list
    WorkSpace.all
  end

  def sort_type_list
    Settings.sort_type_list
  end

  def check_filter_by_category
    return true if @category_id.present?
  end

  def total_post
    Topic.find_by(id: @id).posts.accept.size
  end

  def check_next_thursday
    filter_type[:to_day].present? && (DateTime.parse(filter_type[:to_day]) + 7) > Date.today
  end
  private

  def get_sort_type sort_type
    sort_type_list.include?(sort_type) ? sort_type : Settings.topic.type_sort.recently_answer
  end
end
