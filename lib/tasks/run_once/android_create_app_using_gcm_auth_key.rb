# Usage
# bundle exec rails runner lib/tasks/run_once/android_create_app_using_gcm_auth_key.rb

# create android app in db
app = Rpush::Gcm::App.create(
  name: PushNotify::APP_NAME[:android],
  auth_key: ENV['GCM_AUTH_KEY']
)

puts 'android app created' if app