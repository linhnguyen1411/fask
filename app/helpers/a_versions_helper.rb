module AVersionsHelper

	def load_approve_reject_a_version_button version
		if version.status == "accept"
			(link_to "javascript:", class: "btn-reject-a-version", data: {id: version.id, status: :reject} do
      raw '<i class="fa fa-times" aria-hidden="true"></i> Reject '
      end)
    else
			(link_to "javascript:", data: {id: version.id, status: :accept, 
			type: @post.class.name, post_id: @post.id,content: version.content},
	      class: "btn-approve-a-version", id: "accept-#{version.id}" do
	      raw '<i class="fa fa-check" aria-hidden="true"></i> Accept' 
	    end) + " | " +
	    (link_to "javascript:", class: "btn-reject-a-version", data: {id: version.id, status: :reject} do
	      raw '<i class="fa fa-times" aria-hidden="true"></i> Reject '
	      end)
	  end
	end 
end
 