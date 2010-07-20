# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_address_book_session',
  :secret      => 'dde9067ddae24b927739e12f1c65858977ef0271bd15f51e88be9b7d46e3f0980149f6da53897d0ec551e5cf2a6a47e22561a1a4964b3ea39ef10332b9f192d7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
