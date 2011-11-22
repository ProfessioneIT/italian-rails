module ItalianRails
  class Configuration
    attr_accessor :codice_fiscale, :cap_lookup

    # Provides a default configuration
    def initialize
      @codice_fiscale = CodiceFiscaleConfiguration.new
      @cap_lookup = CapLookupConfiguration.new
    end
  end

  class CodiceFiscaleConfiguration
    attr_accessor :birthdate_selector, :birthplace_selector, :birthplace_lookup, 
      :birthdate_localize,
      :birthdate_day_selector, :birthdate_month_selector, :birthdate_year_selector
  end

  class CapLookupConfiguration
    attr_accessor :lookup_by_prov, :lookup_by_cap
  end

end
