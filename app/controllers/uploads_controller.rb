# frozen_string_literal: true

class UploadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @picture_url = params[:picture_url]
  end

  def new; end

  def create
    ext_name = image_param.original_filename.match(/\.(.*)$/)[1]
    # 不會去修改電腦的 config file，只在 console 裡使用
    Aws.config.update(
      { credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_ACCESS_KEY']),
        region: ENV['AWS_REGION'] }
    )

    identifier = SecureRandom.base58(28)
    bucket_name = ENV['AWS_S3_BUCKET_NAME']
    Aws::S3::Client.new.put_object({
                                     body: image_param.read,
                                     bucket: bucket_name,
                                     key: "#{identifier}.#{ext_name}"
                                   })
    @picture_url = "https://#{bucket_name}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{identifier}.#{ext_name}"
    redirect_to uploads_path(params: { picture_url: @picture_url })
  end

  private

  def image_param
    params.require(:image)
  end
end
