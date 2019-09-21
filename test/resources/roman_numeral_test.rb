# frozen_string_literal: true

require File.dirname(__FILE__) + '/../test_helper'
require_relative '../../app/resources/roman_numeral'

class RomanNumeralTest < ActiveSupport::TestCase
  test '#to_s_1' do
    roman_numeral = RomanNumeral.new(numeral: 1)
    assert { roman_numeral.to_s == 'I' }
  end

  test '#to_s_2' do
    roman_numeral = RomanNumeral.new(numeral: 2)
    assert { roman_numeral.to_s == 'II' }
  end

  test '#to_s_3' do
    roman_numeral = RomanNumeral.new(numeral: 3)
    assert { roman_numeral.to_s == 'III' }
  end

  test '#to_s_4' do
    roman_numeral = RomanNumeral.new(numeral: 4)
    assert { roman_numeral.to_s == 'IV' }
  end

  test '#to_s_5' do
    roman_numeral = RomanNumeral.new(numeral: 5)
    assert { roman_numeral.to_s == 'V' }
  end

  test '#to_s_6' do
    roman_numeral = RomanNumeral.new(numeral: 6)
    assert { roman_numeral.to_s == 'VI' }
  end

  test '#to_s_7' do
    roman_numeral = RomanNumeral.new(numeral: 7)
    assert { roman_numeral.to_s == 'VII' }
  end

  test '#to_s_8' do
    roman_numeral = RomanNumeral.new(numeral: 8)
    assert { roman_numeral.to_s == 'VIII' }
  end

  test '#to_s_9' do
    roman_numeral = RomanNumeral.new(numeral: 9)
    assert { roman_numeral.to_s == 'IX' }
  end

  test '#to_s_10' do
    roman_numeral = RomanNumeral.new(numeral: 10)
    assert { roman_numeral.to_s == 'X' }
  end

  test '#to_s_12' do
    roman_numeral = RomanNumeral.new(numeral: 12)
    assert { roman_numeral.to_s == 'XII' }
  end

  test '#to_s_42' do
    roman_numeral = RomanNumeral.new(numeral: 42)
    assert { roman_numeral.to_s == 'XLII' }
  end

  test '#to_s_49' do
    roman_numeral = RomanNumeral.new(numeral: 49)
    assert { roman_numeral.to_s == 'XLIX' }
  end

  test '#to_s_89' do
    roman_numeral = RomanNumeral.new(numeral: 89)
    assert { roman_numeral.to_s == 'LXXXIX' }
  end

  test '#to_s_99' do
    roman_numeral = RomanNumeral.new(numeral: 99)
    assert { roman_numeral.to_s == 'XCIX' }
  end

  test '#to_s_100' do
    roman_numeral = RomanNumeral.new(numeral: 100)
    assert { roman_numeral.to_s == 'C' }
  end

  test '#to_s_299' do
    roman_numeral = RomanNumeral.new(numeral: 299)
    assert { roman_numeral.to_s == 'CCXCIX' }
  end

  test '#to_s_493' do
    roman_numeral = RomanNumeral.new(numeral: 493)
    assert { roman_numeral.to_s == 'CDXCIII' }
  end

  test '#to_s_1000' do
    roman_numeral = RomanNumeral.new(numeral: 1000)
    assert { roman_numeral.to_s == 'M' }
  end

  test '#to_s_1960' do
    roman_numeral = RomanNumeral.new(numeral: 1960)
    assert { roman_numeral.to_s == 'MCMLX' }
  end

  test '#to_s_2018' do
    roman_numeral = RomanNumeral.new(numeral: 2018)
    assert { roman_numeral.to_s == 'MMXVIII' }
  end

  test '#to_s_3999' do
    roman_numeral = RomanNumeral.new(numeral: 3999)
    assert { roman_numeral.to_s == 'MMMCMXCIX' }
  end

  test '式展開' do
    roman_numeral = RomanNumeral.new(numeral: 24)
    assert { "#{roman_numeral}" == 'XXIV' }
  end

  test '#to_s, 0' do
    roman_numeral = RomanNumeral.new(numeral: 0)
    e = assert_raises RomanNumeral::RangeError do
      roman_numeral.to_s
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#to_s, 4000' do
    roman_numeral = RomanNumeral.new(numeral: 4000)
    e = assert_raises RomanNumeral::RangeError do
      roman_numeral.to_s
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#+' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)
    assert { "#{roman_numeral1 + roman_numeral2}" == 'XXIV' }
  end

  test '#to_s, type error' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    e = assert_raises RomanNumeral::TypeError do
      roman_numeral1 + 'dummy'
    end
    assert { e.message == 'argument must be RomanNumeral' }
  end
end
