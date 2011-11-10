jQuery(function($){
  cf_selector = 'input.codice_fiscale';
  birthdate_selector = 'input.birthdate';
  male_selector = 'input.male';
  female_selector = 'input.female';

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
