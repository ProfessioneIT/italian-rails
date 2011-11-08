module CodiceFiscale
  class CF

    FORMAT_NO_CHECK_DIGIT = /([A-Z]{6})([\dL-V]{2})([A-Z])([\dL-V]{2})([A-Z][\dL-V]{3})/
    FORMAT = /#{FORMAT_NO_CHECK_DIGIT}[A-Z]/
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
    
    def self.valid?(str)
      return false unless str
      str.upcase!
      return false unless str =~ FORMAT
      return false unless str[-1,1] == self.check_digit(str[0..14],true)
      true
    end

    def self.check_digit(str,format_ok=false)
      unless format_ok
        raise ArgumentError unless str
        str.upcase!
        raise ArgumentError unless str =~ FORMAT_NO_CHECK_DIGIT
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

    def self.translate_duplicate_code_without_check_digit(str)
      str =~ FORMAT_NO_CHECK_DIGIT
      name, yr, mt, dy, place = $1, $2, $3, $4, $5
      yr.tr!('LMNPQRSTUV','0123456789')
      dy.tr!('LMNPQRSTUV','0123456789') 
      place[1..4] = place[1..4].tr('LMNPQRSTUV','0123456789')
      [name, yr, mt, dy, place].join("")
    end

  end
end
