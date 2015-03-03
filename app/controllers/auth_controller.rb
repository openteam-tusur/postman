class AuthController < ApplicationController
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => t('cancan.access_denied')
  end
end
