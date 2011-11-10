Rails.application.routes.draw do
    match "/codice_fiscale" => "italian_rails/main#codice_fiscale"
end
