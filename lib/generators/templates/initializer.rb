# This is the configuration of italian-rails engine.
# Please user README in the gem root for reference.
ItalianRails.config do |config|

  # Configure the codice_fiscale form helpers
  # Assign an empty string to selectors to avoid assignment and
  # autocompletion activation in forms.
  
  # Set the selector for birthdate.
  config.codice_fiscale.birthdate_selector = 'input.birthdate'
  config.codice_fiscale.birthdate_localize = false

  # You can use also single selectors for the date fields
  # config.codice_fiscale.birthdate_day_selector = 'input.birthdate_day'
  # config.codice_fiscale.birthdate_month_selector = 'input.birthdate_month'
  # config.codice_fiscale.birthdate_year_selector = 'input.birthdate_year'

  # The form birthplace selector
  config.codice_fiscale.birthplace_selector = 'input.birthplace'

  # Should ItalianRails search for the birthplace in the database ?
  config.codice_fiscale.birthplace_lookup = true

  # Configure the cap, province and city lookup

  # Shuld italian-rails look for provinces that match?
  config.cap_lookup.lookup_by_prov = true

  # Shuld italian-rails look for cap that match?
  config.cap_lookup.lookup_by_cap = true
end
