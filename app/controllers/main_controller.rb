module ItalianRails
  # This controller handles AJAX requests from user interface
  class MainController < ::ApplicationController

    unloadable

    before_filter :only_ajax!

    def codice_fiscale
      @cf = CodiceFiscale::CF.new(params[:codice_fiscale])
      @birthplaces = @cf.birthplace_lookup.collect{|place| "#{place[:comune]} (#{place[:provincia]})" } if ItalianRails.config.codice_fiscale.birthplace_lookup && @cf.valid?

      respond_to do |format|
        format.js
      end
    end

    def cap_lookup
      case params[:key]
      when 'prov'
        if ItalianRails.config.cap_lookup.lookup_by_prov
          result = DB::Adapter.instance.find_places_by_prov(params[:value].upcase)
          @cities = result.collect{|r| r[:frazione].blank? ? r[:comune] : "#{r[:frazione]} #{r[:comune]}" }.uniq
          @caps = result.collect{|r| r[:cap] }.uniq
        end
      when 'cap'
        if ItalianRails.config.cap_lookup.lookup_by_cap
          result = DB::Adapter.instance.find_cities_by_cap(params[:value])
          @cities = result.collect{|r| r[:frazione].blank? ? r[:comune] : "#{r[:frazione]} #{r[:comune]}" }.uniq
          @province = result[0].nil? ? nil : result[0][:provincia]
        end
      end
      respond_to do |format|
        format.js
      end
    end

    def only_ajax!
      #render_404 unless request.xhr?
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

  end
end
