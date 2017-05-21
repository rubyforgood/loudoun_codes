module Admin
  class AttachmentsController < ApplicationController
    def destroy
      attachment = Attachment.find_by_id(params[:id])

      if attachment
        attachment.destroy
        redirect_back(fallback_location: root_path, notice: 'Attachment deleted.')
      else
        redirect_back(fallback_location: root_path, notice: 'No such attachment.')
      end
    end
  end
end
