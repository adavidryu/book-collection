require "rails_helper"

RSpec.describe "Books", type: :request do
  it "creates a book with a title and rejects a blank title" do
    expect do
      post books_path, params: { book: { title: "The Hobbit" } }
    end.to change(Book, :count).by(1)

    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("Book was successfully created.")

    expect do
      post books_path, params: { book: { title: "" } }
    end.not_to change(Book, :count)

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include("A title is required.")
  end

  it "adds a book with an author" do
    post books_path, params: { book: { title: "Beloved", author: "Toni Morrison" } }

    expect(Book.last.author).to eq("Toni Morrison")
  end

  it "adds a book with a price" do
    post books_path, params: { book: { title: "Dune", price: 12.99 } }

    expect(Book.last.price).to eq(12.99)
  end

  it "adds a book with a published date" do
    publication_date = Date.new(1965, 8, 1)

    post books_path, params: { book: { title: "Dune", published_date: publication_date } }

    expect(Book.last.published_date).to eq(publication_date)
  end
end
