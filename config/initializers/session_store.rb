# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dragonfly_test_session',
  :secret      => 'ffa2666f304d91aa2128dc60931339a99632f7494fe3fcda143f8f6eccb9001e43026fae8e0c1d65f8e9cb5abedc690fad516fc1fe5e471e756c49357d003fb3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
