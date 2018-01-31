# frozen_string_literal: true

require File.dirname(__FILE__) + '/../test_helper'
require_relative '../../app/resources/roman_numeral'

class RomanNumeralTest < ActiveSupport::TestCase
  test '#to_s, ⅩⅡ' do
    roman_numeral = RomanNumeral.new(numeral: 12)
    assert_equal 'ⅩⅡ', roman_numeral.to_s
  end

  test '#to_s, ⅩⅩⅣ' do
    roman_numeral = RomanNumeral.new(numeral: 24)
    assert_equal 'ⅩⅩⅣ', roman_numeral.to_s
  end

  test '#+, ⅩⅩⅣ' do
    roman_numeral1 = RomanNumeral.new(numeral: 12)
    roman_numeral2 = RomanNumeral.new(numeral: 12)
    assert_equal 'ⅩⅩⅣ', "#{roman_numeral1 + roman_numeral2}"
  end
end
