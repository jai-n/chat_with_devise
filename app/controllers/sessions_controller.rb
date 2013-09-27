class SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def create   
    self.resource = warden.authenticate!(auth_options)
    self.resource.update_attribute :status,true
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    # respond_with resource, :location => after_sign_in_path_for(resource)
    redirect_to root_path
  end
 # DELETE /resource/sign_out
  def destroy
    debugger
    current_user.update_attribute :status,false
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?
    redirect_to root_path
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    # respond_to do |format|
    #   format.all { head :no_content }
    #   format.any(*navigational_formats) { redirect_to redirect_path }
    # end
  end
end