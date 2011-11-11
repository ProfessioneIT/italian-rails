jQuery(function($){
  cf_selector = 'input.codice_fiscale';

  $(cf_selector).blur(function(){
    $.ajax({
      url: "/codice_fiscale.js",
      data: {
        codice_fiscale: $(this).val()
      },
      dataType: "script"
    });
  });
});
