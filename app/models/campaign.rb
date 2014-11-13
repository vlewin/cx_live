class Campaign < ActiveRecord::Base
  has_many :images

  def import(file)
    spreadsheet = Roo::Excelx.new(file.path, file_warning: :ignore)
    headers = spreadsheet.row(1)

    columns = []
    headers.each_with_index do |header, index|
      header = (header.length > 12) ? "column_#{index}" : header.underscore
      columns.push(header)
    end

    ap columns
    #(2..spreadsheet.last_row).each do |i|
    (2..3).each do |i|
      row = Hash[[columns, spreadsheet.row(i)].transpose]
      byebug
      image = self.images.create(url: row['image_url'])

      row.each do |name, value|
        image.tags.create(name: name, value: value)
      end
    end
  end
end
