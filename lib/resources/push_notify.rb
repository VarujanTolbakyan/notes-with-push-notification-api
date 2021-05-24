class PushNotify
  MSG = {
    invalid_app_type: 'Please provide a valid App type'
  }

  APP_NAME = {
    android: :android,
    ios: :ios
  }

  class << self
    # @param type [Symbol] type of app
    # @param options [Hash] Notification options
    def push(type, options)
      case type
      when :android
        app = Rpush::Gcm::App.find_by_name(:android)
        push_android(app, options)
      # when :ios
      #   app = Rpush::Apns::App.find_by_name(:ios)
      #   push_ios(app, options)
      else
        [false, MSG[:invalid_app_type]]
      end
    end

    def push_android(app, options)
      options = options.slice(:registration_ids, :data).merge(app: app)
      Rpush::Gcm::Notification.new(options).save!
    end

    # def push_ios(app, options)
    #   options = options.slice(:device_token, :alert, :data).merge(app: app)
    #   Rpush::Apns::Notification.new(options).save!
    # end
  end
end