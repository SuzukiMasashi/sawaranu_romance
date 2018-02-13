# frozen_string_literal: true

require File.dirname(__FILE__) + '/../test_helper'
require_relative '../../app/resources/roman_numeral'

class RomanNumeralTest < ActiveSupport::TestCase
  test '#to_s, ⅩⅠⅠ' do
    roman_numeral = RomanNumeral.new(numeral: 12)
    assert_equal 'ⅩⅠⅠ', roman_numeral.to_s
  end

  test '式展開, ⅩⅩⅠⅤ' do
    roman_numeral = RomanNumeral.new(numeral: 24)
    assert_equal 'ⅩⅩⅠⅤ', "#{roman_numeral}"
  end

  test '#+, ⅩⅩⅠⅤ' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)
    assert_equal 'ⅩⅩⅠⅤ', "#{roman_numeral1 + roman_numeral2}"
  end
end
