class Alert < ApplicationRecord
  scope :messages_with_symbols, lambda { |symbols|
    symbols = symbols.map { |v| "%#{v}%" }
    where('message LIKE ANY (array[?])', symbols)
  }
end
