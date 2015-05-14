module Helpers
  def successLoginData
    {
        "id" => 1,
        "cognome" => "Administrator",
        "nome" => "Administrator",
        "username" => "admin",
        "urrs" => [
            {
                "id" => 1,
                "unit" =>
                    {
                        "id" => 1002,
                        "name" => "Thesaurus"
                    },
                "role" =>
                    {
                        "id" => 1001,
                        "name" => "Dirigente"
                    }
            }
        ],
        "sessionId" => "366eaa09-ec6d-42bc-a7e0-93ddb6a26e9c"
    }
  end

  def errorLoginData
    {"error" => {"message" => "Nome utente inesistente o password non valida"}}
  end

  def authorizedDouble(data = nil)
    authorized = double()
    expect(authorized).to receive(:code) { 200 }
    expect(authorized).to receive(:to_h) { data || successLoginData }
    authorized
  end

  def unauthorizedDouble
    unathorized = double()
    expect(unathorized).to receive(:code) { 401 }
    unathorized
  end
end
