class AuthController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => t('cancan.access_denied')
  end
end
