# This is the configuration of italian-rails engine.
# Please user README in the gem root for reference.
ItalianRails.config do |config|

  # Configure the codice_fiscale form helpers
  config.codice_fiscale.birthdate_selector = 'input.birthdate'
  config.codice_fiscale.birthplace_selector = 'input.birthplace'
  config.codice_fiscale.birthplace_lookup = false
end
