require 'sinatra'
require 'sinatra/reloader' if development?

class CaesarCypher
  def initialize(shift)
    @alphabet = ("a".."z").to_a.join + ("A".."Z").to_a.join
    @shifted_alphabet = @alphabet.chars.rotate(shift).join
  end

  def encrypt(text)
    text.tr(@alphabet, @shifted_alphabet)
  end

  def decode(text)
    text.tr(@shifted_alphabet, @alphabet)
  end
end

get '/' do
  string = params["string"]
  encrypt_shift = params["encrypt_shift"].to_i
  cypher = params["cypher"]
  decode_shift = params["decode_shift"].to_i

  if cypher.nil? && !string.nil?
    encrypted_string = CaesarCypher.new(encrypt_shift).encrypt(string)
  elsif string.nil? && !cypher.nil?
    decoded_string = CaesarCypher.new(decode_shift).decode(cypher)
  end

  erb :index, :locals => {
    :encrypted_string => encrypted_string,
    :decoded_string => decoded_string
  }
end
