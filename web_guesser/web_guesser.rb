require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)
@@guess_remaining = 5

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  background_color = set_background_color(message)

  erb :index, :locals => {
    :number => settings.secret_number,
    :message => message,
    :background_color => background_color,
    :guess_remaining => @@guess_remaining
  }
end

def make_secret_number
  settings.secret_number = rand(100)
  @@guess_remaining = 5
end

def check_guess(guess)
  return nil if guess.nil?

  @@guess_remaining -= 1
  guess = guess.to_i

  if @@guess_remaining == 0
    make_secret_number
    "You've lost but a new number has been created.  Try again!"
  elsif guess == settings.secret_number
    make_secret_number
    "You got it right! A new number has been set."
  elsif (guess - settings.secret_number) > 5
    "Way too high!"
  elsif settings.secret_number - guess > 5
    "Way too low!"
  elsif guess > settings.secret_number
    "Too high!"
  elsif guess < settings.secret_number
    "Too low!"
  end
end

def set_background_color(message)
  if message == "Way too high!" || message == "Way too low!"
    "red"
  elsif message == "Too high!" || message == "Too low!"
    "lightpink"
  elsif message == "You got it right! A new number has been set."
    "green"
  elsif message.nil?
    "white"
  end
end
