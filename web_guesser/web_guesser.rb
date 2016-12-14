require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => settings.secret_number, :message => message}
end

def check_guess(guess)
  guess = guess

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
