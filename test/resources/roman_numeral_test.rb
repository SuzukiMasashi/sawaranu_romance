# frozen_string_literal: true

require File.dirname(__FILE__) + '/../test_helper'
require_relative '../../app/resources/roman_numeral'

class RomanNumeralTest < ActiveSupport::TestCase
  test '#to_s' do
    roman_numeral = RomanNumeral.new(numeral: 12)
    assert { roman_numeral.to_s == 'ⅩⅠⅠ' }
  end

  test '式展開' do
    roman_numeral = RomanNumeral.new(numeral: 24)
    assert { "#{roman_numeral}" == 'ⅩⅩⅠⅤ' }
  end

  test '#+' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)
    assert { "#{roman_numeral1 + roman_numeral2}" == 'ⅩⅩⅠⅤ' }
  end
end
