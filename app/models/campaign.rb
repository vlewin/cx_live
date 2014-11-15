class Campaign < ActiveRecord::Base
  has_many :images, dependent: :destroy
  has_many :tags, through: :images

  def search(values)
    images.includes(:tags).where('tags.value' => values)
  end

  def values_for_tag(tags)
    tags = (tags.is_a? Array) ? tags.map(&:underscore) : tags.underscore
    images.joins(:tags).where('tags.name' => tags).uniq.pluck(:value).compact.sort
  end

  def import(file, number_of_rows=50)
    spreadsheet = Roo::Excelx.new(file.path, file_warning: :ignore)
    headers = spreadsheet.row(1)

    #(2..spreadsheet.last_row).each do |i|
    (2..number_of_rows.to_i).each do |i|
      row = Hash[[headers, spreadsheet.row(i)].transpose]
      next if row['image_url'].blank?
      image = self.images.create(url: row['image_url'])

      row.each_with_index do |(name, value), index|
        column = (name.length > 20) ? "column_#{index}" : name.underscore
        image.tags.create(name: column, description: name, value: value ) if value.present?
      end
    end
  end
end
