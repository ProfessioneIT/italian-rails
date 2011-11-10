require 'date'

module ItalianRails
  module CodiceFiscale
    class CF

      # Regex for validation. It validates the code without the check-digit.
      # It also separates the sections with appropriate grouping. Example:
      # codice_fiscale =~ FORMAT_NO_CHECK_DIGIT
      # name, year, month, day, place = $1, $2, $3, $4, $5
      # Duplication avoidance is handled
      FORMAT_NO_CHECK_DIGIT = /([A-Z]{6})([\dL-V]{2})([ABCDEHLMPRST])([\dL-V]{2})([A-Z][\dL-V]{3})/

      # Regex for validation. It validates the code with the check-digit
      # It also separates the sections with appropriate grouping. Example:
      # codice_fiscale =~ FORMAT_NO_CHECK_DIGIT
      # name, year, month, day, place, check_digit = $1, $2, $3, $4, $5, $6
      # Duplication avoidance is handled
      FORMAT = /#{FORMAT_NO_CHECK_DIGIT}([A-Z])/

      # Check digit translation table for odd positions
      ODD = {
        'A' => 1, '0' => 1, 'B' => 0, '1' => 0,
        'C' => 5, '2' => 5, 'D' => 7, '3' => 7,
        'E' => 9, '4' => 9, 'F' =>13, '5' =>13,
        'G' =>15, '6' =>15, 'H' =>17, '7' =>17,
        'I' =>19, '8' =>19, 'J' =>21, '9' =>21,
        'K' => 2, 'L' => 4, 'M' =>18, 'N' =>20,
        'O' =>11, 'P' => 3, 'Q' => 6, 'R' => 8,
        'S' =>12, 'T' =>14, 'U' =>16, 'V' =>10,
        'W' =>22, 'X' =>25, 'Y' =>24, 'Z' =>23
      }

      # Check digit translation table for even positions
      EVEN = {
        'A' => 0, '0' => 0, 'B' => 1, '1' => 1,
        'C' => 2, '2' => 2, 'D' => 3, '3' => 3,
        'E' => 4, '4' => 4, 'F' => 5, '5' => 5,
        'G' => 6, '6' => 6, 'H' => 7, '7' => 7,
        'I' => 8, '8' => 8, 'J' => 9, '9' => 9,
        'K' =>10, 'L' =>11, 'M' =>12, 'N' =>13,
        'O' =>14, 'P' =>15, 'Q' =>16, 'R' =>17,
        'S' =>18, 'T' =>19, 'U' =>20, 'V' =>21,
        'W' =>22, 'X' =>23, 'Y' =>24, 'Z' =>25
      }

      # Translation for the month field
      MONTHS = {
        'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4,
        'E' => 5, 'H' => 6, 'L' => 7, 'M' => 8,
        'P' => 9, 'R' =>10, 'S' =>11, 'T' => 12
      }

      # Validates a codice fiscale. It checks for format and check-digit correctness
      def self.valid?(str)
        return false unless str
        str.upcase!
        return false unless str =~ FORMAT
        return false unless str[-1,1] == self.check_digit(str[0..14],true)
        true
      end

      # Calulates check digit. It raises +ArgumentError+ if the format is not valid.
      def self.check_digit(str,format_ok=false)
        unless format_ok
          self.upcase_match(str, FORMAT_NO_CHECK_DIGIT)
        end

        sum = 0
        (0..14).each do |i|
          if (i+1).even?
            sum += EVEN[str[i].chr]
          else
            sum += ODD[str[i].chr]
          end
        end
        ((sum % 26) + ?A).chr
      end

      # It returns the codice fiscale parts. It raises +ArgumentError+ if the format is not valid.
      # It upcases the string.
      def self.parts(str)
        self.upcase_match(str, FORMAT)[1,6]
      end

      def self.parts_without_check_digit(str)
        self.upcase_match(str, FORMAT_NO_CHECK_DIGIT)[1,5]
      end

      # Translates a duplicate-avoidance code into a normal one. It leaves intact a normal code.
      # Note that this method does not check for validation but checks for format. An +ArgumentError+ is raised if the format is not matched.
      # The input must be a correctly formatted complete codice fiscale (and may not be valid)
      def self.translate_duplicate_code(str)
        name, yr, mt, dy, place, cd = self.parts(str)
        self.translate!(yr,dy,place)
        [name, yr, mt, dy, place, cd].join("")
      end

      # Translates a duplicate-avoidance code into a normal one. It leaves intact a normal code.
      # Note that this method does not check for validation but checks for format. An +ArgumentError+ is raised if the format is not matched.
      # The input must be a correctly formatted codice fiscale without check digit (and may not be valid)
      def self.translate_duplicate_code_without_check_digit(str)
        name, yr, mt, dy, place = self.parts_without_check_digit(str)
        self.translate!(yr,dy,place)
        [name, yr, mt, dy, place].join("")
      end

      # Returs true if the codice fiscale is from a male subject.
      # It checks for validity. It raises an +ArgumentError+ if the code is not valid.
      def self.male?(str)
        raise ArgumentError unless CF.valid?(str)
        tr = CF.translate_duplicate_code_without_check_digit str
        day = self.part(str, :day).to_i
        day < 40
      end

      # It returns the birth date of the subject. 
      # This method guesses that the subject is less than 100 years old as of today. 
      # This is necessary because the codice fiscale reports only the last two digits from the birth year
      def self.birthdate(str)
        raise ArgumentError unless CF.valid?(str)
        tr = CF.translate_duplicate_code str
        name, yr, mt, dy, place, cd = self.parts(tr)
        year = yr.to_i + 1900

        # We are assuming that the subject is less than 100 years old here
        year += 100 if year + 100 < Date.today.year 

        day = dy.to_i
        day -= 40 if day > 40
        Date.new(year, MONTHS[mt], day)
      end

      # Member functions
      
      # Initializes the instance.
      def initialize(code)
        @code = code      
      end

      [:valid?, :male?, :birthdate].each do |method|
        class_eval "def #{method}; CF.#{method} @code; end"
      end

      private

      def self.part(str,part)
        case part
        when :name
          str[0..5]
        when :year
          str[6..7]
        when :month
          str[8].chr
        when :day
          str[9..10]
        when :place
          str[11..14]
        when :check_digit
          str[15].chr
        end
      end

      def self.upcase_match(str,fmt)
        raise ArgumentError.new("nil input") unless str
        str.upcase!
        raise ArgumentError.new("Input doesn't match with codice fiscale format") unless str =~ fmt
        $~
      end

      TR = ['LMNPQRSTUV','0123456789']

      def self.translate!(yr,dy,pl)
        yr.tr!(TR[0],TR[1])
        dy.tr!(TR[0],TR[1]) 
        pl[1..4] = pl[1..4].tr(TR[0],TR[1])
      end

    end
  end
end
