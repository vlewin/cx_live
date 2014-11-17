require "rails_helper"

describe Campaign do
  subject { FactoryGirl.create(:campaign_with_images) }
  let(:image) { tag.image }
  let(:tag) { subject.tags.first }
  let(:file) { File.open(Rails.root.join('spec/fixtures/spreadsheet.xlsx')) }
  let(:spreadsheet) { }
  let(:long_title) { ('a'..'z').to_a.join('') }

  it { should have_many :images }
  it { should have_many :tags }

  it { should validate_presence_of :name }

  describe '.search' do
    it 'finds images by tag values' do
      expect(subject.search(tag.value)).to include(image)
    end
  end

  describe '.values_for_tag' do
    it 'returns values for given tag' do
      expect(subject.values_for_tag(tag.name)).to include(tag.value)
    end
  end

  describe '#import' do
    subject { FactoryGirl.create(:campaign) }
    it 'imports .xslx files' do
      allow_message_expectations_on_nil

      headers = ['Id', 'RefID', 'Title', 'Categoty', 'image_url', long_title]
      row = ['1', '1', 'Title', 'Categoty', 'http://example.com/image.jpeg', 'long_title']

      expect(Roo::Excelx).to receive(:new).with(file.path, file_warning: :ignore).and_return(spreadsheet)
      expect(spreadsheet).to receive(:row).with(1).and_return headers
      allow(spreadsheet).to receive(:row).and_return row

      subject.import(file, 2)

      expect(Image.count).to eq 1
      expect(Image.last.url).to eq row[4]

      expect(Tag.count).to eq row.size
      expect(Tag.last.name).to eq 'column_5'
    end
  end
end
