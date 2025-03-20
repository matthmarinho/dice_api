class Roll < ApplicationRecord
  VALID_EXPRESSION_REGEX = /\A(?:vant |desv )?\d*d\d+(?:[+-]\d+)?(?: vant| desv)?\z/

  validates :expression, presence: true, format: { with: VALID_EXPRESSION_REGEX, message: "is not a valid dice roll expression" }
  validates :result, presence: true, numericality: { only_integer: true }
end
