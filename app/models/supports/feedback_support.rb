class Supports::FeedbackSupport
  attr_reader :post
    def initialize(user, post_params)
      @user = user
      post_params.each do |post_param|
        instance_variable_set "@#{post_param.first}", post_param.last
      end
    end

    def get_post_of_user
      @user.posts.post_full_includes.newest.page(@page_post).per Settings.paginate_default
    end

    def get_clip_post_of_user
      Post.list_posts_clip(@user.clips.pluck(:post_id))
      .page(@page_clip_post).per Settings.paginate_default
    end

    def get_improvement_post
      AVersion.get_all_post_version_of_user(@user.id, "Post").newest
      .page(@page_improvement_post).per Settings.paginate_default
    end

    def get_active_tab
      @active_tab
    end

    def all_workspaces
      WorkSpace.all
    end

    def all_categories
      Category.all
    end

    def all_statuses
      Post.statuses
    end

    def all_feedback_posts
      if @to_xlsx
        Post.feedback_post.post_of_category(@category_id).post_of_work_space(@work_space_id)
          .newest.by_status(@status)
      else
        Post.feedback_post.post_of_category(@category_id).post_of_work_space(@work_space_id)
         .newest.by_status(@status).page(@page).per Settings.paginate_posts
     end
    end
end
