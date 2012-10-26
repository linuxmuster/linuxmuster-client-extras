# ----------------------------------------
# Show server information from $HOME of user 
# Please uncomment to activate!
# show information every minute
#*/1 *    * * *    root    DISPLAY=:0 /usr/bin/show-server-information

# ----------------------------------------
# Shutdown this host, if user confirms GUI message
# Please uncomment to activate!
# shutdown at 20:00
#0 20    * * *    root    DISPLAY=:0 /usr/bin/check-shutdown
# shutdown at 01:00
#0 1    * * *    root    DISPLAY=:0 /usr/bin/check-shutdown
