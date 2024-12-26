# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.configure do |env|
  env.register_mime_type 'application/javascript', extensions: [ '.js' ]
end


# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
