class ToRomanService
  ROMAN_DICTIONARY = {
       1 => 'Ⅰ',
       5 => 'Ⅴ',
      10 => 'Ⅹ',
      50 => 'Ⅼ',
     100 => 'Ⅽ',
     500 => 'Ⅾ',
    1000 => 'Ⅿ',
  }

  def self.call(numeral:)
    new(numeral: numeral).call
  end

  def initialize(numeral:)
    @numeral = numeral
  end

  def call
    @numeral
      .digits
      .yield_self {|digits| digits.zip([*0..digits.size]) }
      .reverse
      .map {|num, digit| find_roman(num, 10**digit) }
      .compact
      .join
  end

  private

  def find_roman(num, base)
    return nil if num.zero?

    if [4, 9].include?(num)
      "#{ROMAN_DICTIONARY[base]}#{ROMAN_DICTIONARY[base * (num + 1)]}"
    else
      ROMAN_DICTIONARY[base] * num
    end
  end
end
