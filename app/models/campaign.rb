class Campaign < ActiveRecord::Base
  has_many :images
  has_many :tags, through: :images

  def search(values)
    images.includes(:tags).where('tags.value' => values)
  end

  def values_for_tag(tags)
    tags = (tags.is_a? Array) ? tags.map(&:underscore) : tags.underscore
    images.joins(:tags).where('tags.name' => tags).uniq.pluck(:value).compact.sort
  end

  def import(file)
    spreadsheet = Roo::Excelx.new(file.path, file_warning: :ignore)
    headers = spreadsheet.row(1)

    #(2..spreadsheet.last_row).each do |i|
    (2..50).each do |i|
      row = Hash[[headers, spreadsheet.row(i)].transpose]
      image = self.images.create(url: row['image_url'])

      row.each_with_index do |(name, value), index|
        column = (name.length > 20) ? "column_#{index}" : name.underscore
        image.tags.create(name: column, description: name, value: value.present? ? value : nil )
      end
    end
  end
end
