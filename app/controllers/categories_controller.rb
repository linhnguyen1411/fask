class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_event_officer_user, except: :show
  before_action :load_category, except: [:index, :create, :new]
  before_action :load_topic

  def index
    @categories = Category.newest.page(params[:page]).per Settings.paginate_categories
  end

  def show
    @posts = Post.post_by_topic(Settings.topic.feedback).recently_answer.post_of_category(@category)
      .page(params[:page]).per Settings.paginate_default
  end

  def edit;end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @success = false
    if @category.save
      @success = true
      @categories = Category.newest.page(params[:page]).per Settings.paginate_categories
    end
  end

  def update
    @success = @category.update_attributes category_params
  end

  def destroy
    @success = @category.destroy
    @categories = Category.newest.page(params[:page]).per Settings.paginate_categories
    @categories = Category.newest.page(Settings.one_page).per(Settings.paginate_categories) if @categories.empty?
  end

  private

  def check_event_officer_user
    return if User.position_allowed_answer_feedback.include?(current_user)
    respond_to do |format|
      format.js{render}
    end
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    respond_to do |format|
      format.js{render}
    end
  end

  def category_params
    params.require(:category).permit :name
  end

  def load_topic
    @topic = Topic.find_by id: Settings.topic.feedback_number
    return if @topic
    flash[:danger] = t "not_found_topic"
    redirect_to root_path
  end
end
