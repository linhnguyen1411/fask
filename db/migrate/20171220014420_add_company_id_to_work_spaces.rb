class AddCompanyIdToWorkSpaces < ActiveRecord::Migration[5.0]
  def change
    add_reference :work_spaces, :company, foreign_key: true
  end
end
