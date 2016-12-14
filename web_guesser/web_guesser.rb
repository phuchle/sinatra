require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  background_color = set_background_color(message)

  erb :index, :locals => {
    :number => settings.secret_number,
    :message => message,
    :background_color => background_color
  }
end

def check_guess(guess)
  return nil if guess.nil?
  
  guess = guess.to_i
  if (guess - settings.secret_number) > 5
    "Way too high!"
  elsif settings.secret_number - guess > 5
    "Way too low!"
  elsif guess > settings.secret_number
    "Too high!"
  elsif guess < settings.secret_number
    "Too low!"
  elsif guess == settings.secret_number
    "You got it right!"
  end
end

def set_background_color(message)
  if message == "Way too high!" || message == "Way too low!"
    "red"
  elsif message == "Too high!" || message == "Too low!"
    "lightpink"
  elsif message == "You got it right!"
    "green"
  elsif message.nil?
    "white"
  end
end
