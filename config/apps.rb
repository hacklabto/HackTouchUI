##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do

end

# Mounts the core application for this project
Padrino.mount("App").to('/')
