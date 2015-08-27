class UploadsController < ApplicationController
  def new
  end

  def create
    begin
      # Make an object in your bucket for your upload
      # obj = S3_BUCKET.objects[params[:file].original_filename]

      s3 = Aws::S3::Resource.new(
              credentials: Aws::Credentials.new(ENV["AKID"], ENV["SECRET"]),
              region: 'us-west-2')
      obj = s3.bucket('vezzani-s3-tutorial').object(params[:file].original_filename)

      # upload the file
      obj.upload_file(params[:file].path, acl: 'public-read')

      # Create an object for the upload
      @upload = Upload.new(
                  url: obj.public_url,
                  name: obj.key
      )

      # Save the upload
      if @upload.save
        redirect_to uploads_path, success: 'File successfully uploaded'
      else
        flash.now[:notice] = 'There was an error'
        render :new
      end

    rescue
      redirect_to new_upload_path
      flash[:notice] = 'Please select a file to upload'
    end
  end

  def index
    @uploads = Upload.all
  end
end
