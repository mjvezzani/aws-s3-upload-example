require 'rails_helper'

describe "Uploader" do
  it "correctly uploads a file" do
    visit root_path

    file_path = Rails.root + "spec/fixtures/upload.txt"
    attach_file('file', file_path)
    click_button "Upload File"

    expect(current_path).to eq uploads_path
    expect(page).to have_content "upload.txt"
  end

  it "displays error message when no file is selected" do
    visit root_path

    click_button "Upload File"

    expect(current_path).to eq new_upload_path
    expect(page).to have_content "Please select a file to upload"
  end
end
