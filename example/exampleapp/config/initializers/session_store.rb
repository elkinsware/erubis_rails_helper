# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_exampleapp_session',
  :secret      => '043c4599b2da7dc3a24d455ddb8e8556b4b4b3a98edfb2e5d4443d4fc0c6ba169d9c793209370b63cfc39d92b9a27889fcc30c9643db8ab848f138a7989d2f2c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
