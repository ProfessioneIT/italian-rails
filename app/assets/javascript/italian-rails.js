jQuery(function($){
  // These values are actually hard-coded. We have to find a way to 
  // let the user specify them in config.
  cf_selector = 'input.codice_fiscale';
  prov_selector = 'input.provincia';
  comu_selector = 'input.comune';
  cap_selector = 'input.cap';

  $(cf_selector).blur(function(){
    $.ajax({
      url: "/codice_fiscale.js",
      data: {
        codice_fiscale: $(this).val()
      },
      dataType: "script"
    });
  });

  cap_lookup = function(evt){
    $.ajax({
      url: "/cap_lookup.js",
      data: {
        key: evt.data.key,
        value: $(this).val()
      },
      dataType: "script"
    });

  $(prov_selector).blur({key:'prov'}, cap_lookup);
  $(cap_selector).blur({key:'cap'}, cap_lookup);
  $(comu_selector).blur({key:'comu'}, cap_lookup);

  };
});
