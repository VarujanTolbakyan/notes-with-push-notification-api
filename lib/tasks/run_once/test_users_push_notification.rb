# Usage
# bundle exec rails runner lib/tasks/run_once/test_users_push_notification.rb

# send push notifications all users who have push_notification_devices
User.all.each do |user|
  devices = user.push_notification_devices

  data = { message: 'This is a test push notification', user_id: user.id }

  PushNotificationDevice.push_notification(devices, data) if devices.present?
end