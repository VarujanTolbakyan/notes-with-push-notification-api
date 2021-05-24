class User < ApplicationRecord
  has_secure_password

  has_many :notes, dependent: :destroy
  has_many :user_push_notification_devices, dependent: :destroy
  has_many :push_notification_devices, through: :user_push_notification_devices

  validates_presence_of :email, :name
  validates :email, uniqueness: true,
    format: { with:  URI::MailTo::EMAIL_REGEXP }

  # To add device info(type and token)
  # @param attrs [Hash] device informations
  def add_device_info(attrs)
    return unless attrs.present? && attrs[:device_type].present? && attrs[:device_token].present?

    device_attr = attrs.slice(:device_type, :device_token)
    device_params = {
      device_type: PushNotificationDevice.device_types[device_attr[:device_type]],
      device_token: device_attr[:device_token]
    }

    device = PushNotificationDevice.find_or_initialize_by(device_params)

    devices = push_notification_devices
    return if devices.include?(device)
    self.push_notification_devices << device
  end
end
