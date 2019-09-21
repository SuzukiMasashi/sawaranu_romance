# frozen_string_literal: true

module Types
  include Dry::Types.module
end

class RomanNumeral < Dry::Struct
  class RangeError < StandardError ; end
  class TypeError < StandardError ; end

  attribute :numeral, Types::Coercible::Int

  ROMAN_DICTIONARY = {
        1  => 'I',
        2  => 'II',
        3  => 'III',
        4  => 'IV',
        5  => 'V',
        6  => 'VI',
        7  => 'VII',
        8  => 'VIII',
        9  => 'IX',
       10  => 'X',
       20  => 'XX',
       30  => 'XXX',
       40  => 'XL',
       50  => 'L',
       60  => 'LX',
       70  => 'LXX',
       80  => 'LXXX',
       90  => 'XC',
      100  => 'C',
      200  => 'CC',
      300  => 'CCC',
      400  => 'CD',
      500  => 'D',
      600  => 'DC',
      700  => 'DCC',
      800  => 'DCCC',
      900  => 'CM',
    1_000  => 'M',
    2_000  => 'MM',
    3_000  => 'MMM'
  }

  def to_s
    raise RangeError, 'numeral must be one of: 1 - 3999' unless numeral.between?(1, 3999)

    roman_str = ''
    balance   = numeral

    [1000, 100, 10, 1].each do |unit|
      div = balance.div(unit)
      if div > 0 && balance > 0
        roman_str += ROMAN_DICTIONARY[div * unit]
        balance   -= div * unit
      end
    end

    roman_str
  end

  def +(other)
    raise TypeError, 'argument must be RomanNumeral' unless other.is_a?(RomanNumeral)

    RomanNumeral.new(numeral: numeral + other.numeral).to_s
  end
end
