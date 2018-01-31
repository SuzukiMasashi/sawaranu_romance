# frozen_string_literal: true

module Types
  include Dry::Types.module
end

class RomanNumeral < Dry::Struct
  class RomanNumeralRangeError < StandardError ; end

  attribute :numeral, Types::Coercible::Int

  def to_s
  end
end
