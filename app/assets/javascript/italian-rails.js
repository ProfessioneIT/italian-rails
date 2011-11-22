jQuery(function($){
  // These values are actually hard-coded. We have to find a way to 
  // let the user specify them in config.
  window.itarails_cf_selector = 'input.codice_fiscale';
  window.itarails_prov_selector = 'input.provincia';
  window.itarails_comu_selector = 'input.comune';
  window.itarails_cap_selector = 'input.cap';

  $(window.itarails_cf_selector).change(function(){
    $.ajax({
      url: "/codice_fiscale.js",
      data: {
        codice_fiscale: $(this).val()
      },
      dataType: "script"
    });
  });

  cap_lookup = function(evt){
    value = $(this).val();
    if( evt.data.validate(value) ) {
      $.ajax({
        url: "/cap_lookup.js",
        data: {
          key: evt.data.key,
          value: value
        },
        dataType: "script"
      });
    }
  };

  prov_validate = function(value){
    return value.match(/[A-Za-z]{2}/);
  };

  cap_validate = function(value){
    return value.match(/\d{5}/);
  };

  $(window.itarails_prov_selector).change({key:'prov', validate: prov_validate}, cap_lookup);
  $(window.itarails_cap_selector).change({key:'cap', validate: cap_validate}, cap_lookup);
});
