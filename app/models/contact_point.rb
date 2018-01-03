class ContactPoint < ApplicationRecord
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    if spreadsheet
      work_spaces = Settings.work_space_list
      ContactPoint.transaction do
        ContactPoint.destroy_all
        position = nil
        (Settings.begin_row_content..spreadsheet.last_row).each do |i|
          position = spreadsheet.row(i)[Settings.col_position] || position
          issue = spreadsheet.row(i)[Settings.col_issue]
          work_spaces.each_with_index do |work_space, index|
            curators = spreadsheet.row(i)[Settings.col_curators + index]
            values = [position, issue, curators, work_space]
            ContactPoint.create! Hash[[Settings.columns_of_contact_points, values].transpose]
          end
        end
      end
    end
  rescue
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else  false end
  end
end
