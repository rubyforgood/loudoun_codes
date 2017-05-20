class AttachmentsController < ApplicationController
  def show
    attachment = Attachment.find_by_id(params[:id])

    if attachment
      send_file(attachment.path, type: attachment.content_type)
    else
      render plain: 'Not found', status: 404 # this should never happen
    end
  end
end
