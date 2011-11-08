module UserSpec
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes(merge_in = {})
    {
      :name => "Mario",
      :surname => "Rossi",
      :male => true,
      :codice_fiscale_code => "RSSMRA90A01C351Q",
      :birthdate => Date.new(1990,1,1),
      :birthplace => "Catania"
    }.merge merge_in
  end
end
