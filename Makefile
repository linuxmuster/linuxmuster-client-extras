#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

# Virtualbox
VBOXDIR=$(DESTDIR)/usr/bin
VIRTCONF=$(DESTDIR)/etc/leovirtstarter
LEOCLIENTCONF=$(DESTDIR)/etc/leoclient
# Perl modules
PERLMOD=$(DESTDIR)/usr/share/perl5/leoclient
BIN=$(DESTDIR)/usr/bin
SBIN=$(DESTDIR)/usr/sbin
SHARE=$(DESTDIR)/usr/share/linuxmuster-client
INIT=$(DESTDIR)/etc/init.d
# where is the start script linked
START=$(DESTDIR)/etc/rc2.d/S99leoclient

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo ' '
	@echo '   make leoclient-watch-my-home'
	@echo '      install script to trigger alarm, when files/dirs are saved outside a dir'
	@echo ' '
	@echo '   make leoclient-printer-default'
	@echo '      install set default printer script'
	@echo ' '
	@echo '   make leoclient-italc'
	@echo '      install italc stuff'
	@echo ' '
	@echo '   make leoclient-shutdown'
	@echo '      install shutdown script'
	@echo ' '
	@echo '   make leoclient-icon-script'
	@echo '      install scripts to sync desktop icons'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package'
	@echo ' '
	@echo '   make clean'
	@echo '      clean up stuff created by packaging'
	@echo ' '


default: 
	@echo 'Doing Nothing'



# tools
############################################################

leoclient-watch-my-home:
	@echo '   * Installing the script leoclient-watch-my-home'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 watch-my-home/leoclient-watch-my-home $(VBOXDIR)
	@echo '   * Installing the configuration file'
	@install -d -m755 -oroot -groot $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 watch-my-home/leoclient-watch-my-home.conf  $(LEOCLIENTCONF)


# build a package
deb:
	### deb
	@echo 'Did you do a dch -i ?'
	#@sleep 8
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version in git'
	@echo ''

clean:
	rm -rf  debian/leoclient




leoclient-printer-default:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 printer/standarddrucker-nach-raum.sh $(BIN)
	@install -d -m755 -oroot -groot $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 printer/leoclient-printer-default.conf  $(LEOCLIENTCONF)


leoclient-italc:
	@echo '   * Installing italc scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 italc/italc-raumanpassung.sh $(BIN)
	@install -d -m755 -oroot -groot $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 italc/leoclient-italc.conf  $(LEOCLIENTCONF)


leoclient-shutdown:
# no config file
	@echo '   * Installing shutdown script (without cronjob entry)'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 shutdown/herunterfahren.sh $(BIN)




leoclient-icon-script:
	@echo '   * Installing desktop icons'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 desktop-icons/desktop-icons-hinzu.sh $(BIN)

