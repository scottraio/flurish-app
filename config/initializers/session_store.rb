# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_workory-sync_session',
  :secret      => '7e5e06312fc3aa050de5e8c8d422215d6dedd4452fe31e1e3936938706bc496c2ee1386c0d28363ccea957de5a2226f44ef86b5a83f23a794340f6c1c132eb08'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
