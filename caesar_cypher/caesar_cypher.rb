require 'sinatra'
require 'sinatra/reloader'

get '/' do
  string = params["string"]
  encrypt_shift = params["encrypt_shift"].to_i
  cypher = params["cypher"]
  decode_shift = params["decode_shift"].to_i

  encrypted_string = caesar_cypher(string, encrypt_shift) if cypher.nil? && !string.nil?
  decoded_string = caesar_decypher(cypher, decode_shift) if string.nil? && !cypher.nil?

  erb :index, :locals => {
    :encrypted_string => encrypted_string,
    :decoded_string => decoded_string
  }
end

@@alphabet = ("a".."z").to_a + ("A".."Z").to_a

def caesar_cypher(string, shift_factor=0)
	translated = []

	string.split('').each do |letter|
		if @@alphabet.include?(letter)
			shifted_letter = (letter.ord + shift_factor)
			if within_standard_alphabet?(shifted_letter)
				translated << shifted_letter.chr
			else
				translated << (shifted_letter - 26).chr
			end
		else
			translated << letter
		end
	end
	translated.join
end

def caesar_decypher(string, shift_factor=0)
	translated = []

	string.split('').each do |letter|
		if @@alphabet.include? letter
			shifted_letter = (letter.ord - shift_factor)
			if within_standard_alphabet?(shifted_letter)
				translated << shifted_letter.chr
			else
				translated << (shifted_letter + 26).chr
			end
		else
			translated << letter
		end
	end
	translated.join
end

def within_standard_alphabet?(shifted_letter)
  shifted_letter >= 65 && shifted_letter <= 90 ||
  shifted_letter >= 97 && shifted_letter <= 122
end
