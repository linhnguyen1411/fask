module AVersionsHelper

  def load_approve_reject_a_version_button version
    if version.status == Settings.version.accept
      (link_to "javascript:", class: "btn-reject-a-version",
        data: {id: version.id, status: :reject, current_status: version.status, post_id: @post.id} do
          raw '<i class="fa fa-times" aria-hidden="true"></i>' + I18n.t("version.reject")
        end)
    else
      (link_to "javascript:", data: {id: version.id, status: :accept,
        type: @post.class.name, post_id: @post.id, content: version.content},
        class: "btn-approve-a-version", id: "accept-#{version.id}" do
        raw '<i class="fa fa-check" aria-hidden="true"></i> ' + I18n.t("version.accept")
        end) +
      (link_to "javascript:", class: "btn-reject-a-version", data:
        {id: version.id, status: :reject, current_status: version.status, post_id: @post.id } do
          raw '<i class="fa fa-times" aria-hidden="true"></i> ' + I18n.t("version.reject")
        end)
    end
  end
end
