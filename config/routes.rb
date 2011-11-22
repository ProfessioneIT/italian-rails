Rails.application.routes.draw do
  match "/codice_fiscale" => "italian_rails/main#codice_fiscale"
  match "/cap_lookup" => "italian_rails/main#cap_lookup"
end
