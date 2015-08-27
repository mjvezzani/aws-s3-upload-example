require 'rails_helper'

describe Upload do
  before(:each) do
    @upload = Upload.create(
                url: "http://example.com/this_is_my_public_url",
                name: "Public Url 1")
  end
  it "has a public url and name" do
    expect(@upload).to be_valid
  end

  it "is invalid without a url" do
    @upload.url = nil

    expect(@upload).to be_invalid
  end

  it "is invalid without at name" do
    @upload.name = nil

    expect(@upload).to be_invalid
  end
end
