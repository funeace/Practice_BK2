class ApplicationController < ActionController::Base

  # refileを使うためのキー
  Refile.secret_key = 'c21198c18ae08b67112bedbc1f4cab069c88857122d784800e2151ab027a33a718d4ab0e31ac8a3f1abda6fbce4492e7ce1083e8c4b236e16d9eef4395e1cf1b'
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
      # sigh_upの時に、名前も更新の対象にしてくれるパラメーター
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

  def after_sign_in_path_for(resource)
    # ログインしているユーザのid
    user_path(current_user.id)
  end    

  def after_sign_up_path_for(resource)
  # ログインしているユーザのid
  user_path(current_user.id)
  end    

end
