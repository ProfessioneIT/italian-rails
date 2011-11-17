module ItalianRails
  # This controller handles AJAX requests from user interface
  class MainController < ::ApplicationController

    unloadable

    before_filter :only_ajax!

    def codice_fiscale
      @cf = CodiceFiscale::CF.new(params[:codice_fiscale])
      @birthplaces = @cf.birthplace_lookup.collect{|place| "#{place[:comune]} (#{place[:provincia]})" } if ItalianRails.config.codice_fiscale.birthplace_lookup

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
