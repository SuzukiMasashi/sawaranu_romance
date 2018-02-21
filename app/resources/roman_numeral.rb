# frozen_string_literal: true

module Types
  include Dry::Types.module
end

class RomanNumeral < Dry::Struct
  include Comparable

  class RangeError < StandardError ; end

  attribute :numeral, Types::Coercible::Int

  def to_s
    validate_numeral(numeral) do
      ToRomanService.call(numeral: numeral)
    end
  end

  def +(other)
    new(numeral: numeral + other.numeral)
  end

  def -(other)
    new(numeral: numeral - other.numeral)
  end

  def /(other)
    new(numeral: numeral / other.numeral)
  end

  def *(other)
    new(numeral: numeral * other.numeral)
  end

  # Object#==を再定義
  def ==(other)
    numeral == other.numeral
  end

  # Comparableモジュールをincludeして<=>を再定義すると<,<=,>=,>が定義される
  def <=>(other)
    numeral <=> other.numeral
  end

  private

  def validate_numeral(numeral)
    errors = RomanNumeralSchema.call(numeral: numeral).messages(full: true)

    if errors.present?
      raise RangeError, errors[:numeral].join("\n")
    else
      yield
    end
  end

  RomanNumeralSchema = Dry::Validation.Schema do
    required(:numeral).value(included_in?: 1..3999)
  end
end
