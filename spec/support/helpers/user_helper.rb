module Helpers
  #@jtodoLOW Factory girl!
  def createFakeUser(to_hash = nil)
    @user = IntersailAuth::User.new(
        cognome: "cognome",
        nome: "nome",
        username: "user",
        urrs_id: "1",
        urrs_unit_id: "urrs_unit_id",
        urrs_unit_name: "urrs_unit_name",
        urrs_role_id: "urrs_role_id",
        urrs_role_name: "urrs_role_name",
        z_auth_token: "z_auth_token",
        auth_hash: "auth_hash"
    )
    makeHashIfGiven(to_hash)
    @user.save
  end

  def makeHashIfGiven(to_hash)
    @user.auth_hash = @user.buildHash to_hash if to_hash
  end
end