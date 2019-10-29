# Compile the assets
bundle exec rails assets:precompile

# Migrate
bundle exec rails db:create db:migrate

# Start the server
bundle exec rails server