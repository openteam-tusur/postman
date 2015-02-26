class Property::SmsesController < ApplicationController
  before_filter :find_property_sms, :only => [:show, :edit, :update, :destroy]

  def index
    @property_smses = Property::Sms.all
  end

  def show
  end

  def new
    @property_sms = Property::Sms.new
  end

  def create
    @property_sms = Property::Sms.new(sms_properties_params)
    if @property_sms.save
      redirect_to property_sms_path(@property_sms) and return
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property_sms.update(sms_properties_params)
      redirect_to property_sms_path(@property_sms) and return
    else
      render :edit
    end
  end

  def destroy
    @property_sms.destroy
    redirect_to property_smses_path and return
  end

  private

  def find_property_sms
    @property_sms = Property::Sms.find(params[:id])
  end

  def sms_properties_params
    params.require(:property_sms).permit(:title, :url, :footer, :slug)
  end
end
