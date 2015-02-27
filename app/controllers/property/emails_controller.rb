class Property::EmailsController < AuthController
  before_filter :find_property_email, :only => [:show, :edit, :update, :destroy]

  def index
    @property_emails = Property::Email.all
  end

  def show
  end

  def new
    @property_email = Property::Email.new
  end

  def create
    @property_email = Property::Email.new(email_properties_params)
    if @property_email.save
      redirect_to property_email_path(@property_email) and return
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property_email.update(email_properties_params)
      redirect_to property_email_path(@property_email) and return
    else
      render :edit
    end
  end

  def destroy
    @property_email.destroy
    redirect_to property_emails_path and return
  end

  private

  def find_property_email
    @property_email = Property::Email.find(params[:id])
  end

  def email_properties_params
    params.require(:property_email).permit(:title, :url, :footer, :slug, :email)
  end
end
