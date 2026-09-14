require "rails_helper"

RSpec.describe Book, type: :model do
  it "requires a title" do
    book = Book.new(title: "")

    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end

  it "has an author stored as a string" do
    expect(Book.columns_hash["author"].type).to eq(:string)
  end

  it "has a price stored as a decimal" do
    expect(Book.columns_hash["price"].type).to eq(:decimal)
  end

  it "has a published date stored as a date" do
    expect(Book.columns_hash["published_date"].type).to eq(:date)
  end
end
