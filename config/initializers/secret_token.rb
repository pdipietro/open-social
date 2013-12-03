# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#Myapp::Application.config.secret_token = 'bce995b576dec8682548deab91d16916f837bd2a033cf04be2ab3c0e229082b4451d3ac5ab21cb29f66f25afb1a8a7a5fca2c740b03cdd39ad3a782187cfada4'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Myapp::Application.config.secret_key_base = secure_token
Myapp::Application.config.secret_token = secure_token
