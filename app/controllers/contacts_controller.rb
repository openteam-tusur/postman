class ContactsController < AuthController
  def show
    @contact = Contact.find(params[:id])
  end
end
