module ContactPointsHelper
  def group_by_issue contact_points
    contact_points.group_by{ |contact_point| contact_point.issue }
  end

  def group_by_position contact_points
    contact_points.group_by { |contact_point| contact_point.position}
  end

  def newline str
    raw str.gsub("\n", '<br />') if str.present?
  end
end
