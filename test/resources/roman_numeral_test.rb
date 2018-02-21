# frozen_string_literal: true

require File.dirname(__FILE__) + '/../test_helper'
require_relative '../../app/resources/roman_numeral'
require_relative '../../app/services/to_roman_service'

class RomanNumeralTest < ActiveSupport::TestCase
  test '#to_s, 12' do
    roman_numeral = RomanNumeral.new(numeral: 12)

    assert { roman_numeral.to_s == 'ⅩⅠⅠ' }
  end

  test '#to_s, 4' do
    roman_numeral = RomanNumeral.new(numeral: 4)

    assert { roman_numeral.to_s == 'ⅠⅤ' }
  end

  test '#to_s, 9' do
    roman_numeral = RomanNumeral.new(numeral: 9)

    assert { roman_numeral.to_s == 'ⅠⅩ' }
  end

  test '#to_s, 40' do
    roman_numeral = RomanNumeral.new(numeral: 40)

    assert { roman_numeral.to_s == 'ⅩⅬ' }
  end

  test '#to_s, 90' do
    roman_numeral = RomanNumeral.new(numeral: 90)

    assert { roman_numeral.to_s == 'ⅩⅭ' }
  end

  test '#to_s, 400' do
    roman_numeral = RomanNumeral.new(numeral: 400)

    assert { roman_numeral.to_s == 'ⅭⅮ' }
  end

  test '#to_s, 900' do
    roman_numeral = RomanNumeral.new(numeral: 900)

    assert { roman_numeral.to_s == 'ⅭⅯ' }
  end

  test '#to_s, 2444' do
    roman_numeral = RomanNumeral.new(numeral: 2444)

    assert { roman_numeral.to_s == 'ⅯⅯⅭⅮⅩⅬⅠⅤ' }
  end

  test '#to_s, 3999' do
    roman_numeral = RomanNumeral.new(numeral: 3999)

    assert { roman_numeral.to_s == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
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

  test '式展開' do
    roman_numeral = RomanNumeral.new(numeral: 24)

    assert { "#{roman_numeral}" == 'ⅩⅩⅠⅤ' }
  end

  test '#+, 12 + 12' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)

    assert { "#{roman_numeral1 + roman_numeral2}" == 'ⅩⅩⅠⅤ' }
  end

  test '#+, 1 + 0' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 0)

    assert { "#{roman_numeral1 + roman_numeral2}" == 'Ⅰ' }
  end

  test '#+, 0 + 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 0)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    assert { "#{roman_numeral1 + roman_numeral2}" == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
  end

  test '#+, 2000 + 2000' do
    roman_numeral1 = RomanNumeral.new(numeral: 2000)
    roman_numeral2 = RomanNumeral.new(numeral: 2000)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 + roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#-, 1 - 0' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 0)

    assert { "#{roman_numeral1 - roman_numeral2}" == 'Ⅰ' }
  end

  test '#-, 3999 - 0' do
    roman_numeral1 = RomanNumeral.new(numeral: 3999)
    roman_numeral2 = RomanNumeral.new(numeral: 0)

    assert { "#{roman_numeral1 - roman_numeral2}" == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
  end

  test '#-, 0 - 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 0)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 - roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#/, 1 / 0' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 0)

    e = assert_raises ZeroDivisionError do
      "#{roman_numeral1 / roman_numeral2}"
    end
    assert { e.message == 'divided by 0' }
  end

  test '#/, 0 / 1' do
    roman_numeral1 = RomanNumeral.new(numeral: 0)
    roman_numeral2 = RomanNumeral.new(numeral: 1)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 / roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#/, 3999 / 1' do
    roman_numeral1 = RomanNumeral.new(numeral: 3999)
    roman_numeral2 = RomanNumeral.new(numeral: 1)

    assert { "#{roman_numeral1 / roman_numeral2}" == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
  end

  test '#/, 1 / 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 / roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#/, 4000 / 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 4000)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    assert { "#{roman_numeral1 / roman_numeral2}" == 'Ⅰ' }
  end

  test '#*, 1 * 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    assert { "#{roman_numeral1 * roman_numeral2}" == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
  end

  test '#*, 3 * 1333' do
    roman_numeral1 = RomanNumeral.new(numeral: 3)
    roman_numeral2 = RomanNumeral.new(numeral: 1333)

    assert { "#{roman_numeral1 * roman_numeral2}" == 'ⅯⅯⅯⅭⅯⅩⅭⅠⅩ' }
  end

  test '#*, 1 * 0' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 0)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 * roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#*, 0 * 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 0)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    e = assert_raises RomanNumeral::RangeError do
      "#{roman_numeral1 * roman_numeral2}"
    end
    assert { e.message == 'numeral must be one of: 1 - 3999' }
  end

  test '#==, 12 == 12' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)

    assert { roman_numeral1 == roman_numeral2 }
  end

  test '#<, 1 < 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    assert { roman_numeral1 < roman_numeral2 }
  end

  test '#<=, 1 <= 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 1)
    roman_numeral2 = RomanNumeral.new(numeral: 3999)

    assert { roman_numeral1 <= roman_numeral2 }
  end

  test '#<=, 12 <= 12' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)

    assert { roman_numeral1 <= roman_numeral2 }
  end

  test '#<, 3999 > 1' do
    roman_numeral1 = RomanNumeral.new(numeral: 3999)
    roman_numeral2 = RomanNumeral.new(numeral: 1)

    assert { roman_numeral1 > roman_numeral2 }
  end

  test '#<=, 1 >= 3999' do
    roman_numeral1 = RomanNumeral.new(numeral: 3999)
    roman_numeral2 = RomanNumeral.new(numeral: 1)

    assert { roman_numeral1 >= roman_numeral2 }
  end

  test '#<=, 12 >= 12' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)

    assert { roman_numeral1 >= roman_numeral2 }
  end
end
