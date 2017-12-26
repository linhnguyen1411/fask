module Supports
  class Dashboard::PostSupport
    attr_reader :post

    def initialize(user, page_post, page_clip_post, page_improvement_post, active_tab)
      @user = user
      @page_post = page_post
      @page_clip_post = page_clip_post
      @page_improvement_post = page_improvement_post
      @active_tab = active_tab
    end

    def get_post_of_user
      @user.posts.newest.page(@page_post).per Settings.paginate_default
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
  end
end
