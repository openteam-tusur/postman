class ContactsController < AuthController
  def show
    @contact = Contact.find(params[:id])
  end

  def rehabilitate
    Contact.find(params[:contact_id]).update_attribute :status, 'good'

    redirect_to :back, notice: 'Реабилитировано'
  end
end
