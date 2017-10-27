# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << '#{Rails.root}/app/assets/stylesheets'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
#Rails.application.config.assets.precompile += %w( rails.validations.js jstree.js jstree.min.js three.min.js \
#  go_contact_before_signin.js user_status_reports.js on_boardings.js off_boardings.js internal_transfer.js loa.js\
#  jstree.css)
Rails.application.config.assets.precompile += %w( all.css )
Rails.application.config.assets.precompile += %w( Jcrop.css Jcrop.js Jcrop.gif )
