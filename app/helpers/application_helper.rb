module ApplicationHelper
  def image_tag source, options={}
    source = "no_avatar" if source.blank?
    super source, options
  end
end
