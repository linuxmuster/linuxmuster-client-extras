#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

CONF=$(DESTDIR)/etc/linuxmuster-client/extras
BIN=$(DESTDIR)/usr/bin

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make watch-my-home'
	@echo '      install script to trigger alarm, when files/dirs are saved outside a dir'
	@echo ' '
	@echo '   make printer-default'
	@echo '      install set default printer script'
	@echo ' '
	@echo '   make italc'
	@echo '      install italc stuff'
	@echo ' '
	@echo '   make shutdown'
	@echo '      install shutdown script'
	@echo ' '
	@echo '   make icon-script'
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


watch-my-home:
	@echo '   * Installing the script watch-my-home'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 watch-my-home/watch-my-home $(BIN)
	@echo '   * Installing the configuration file'
	@install -d -m755 -oroot -groot $(CONF)
	@install -oroot -groot --mode=0644 watch-my-home/watch-my-home.conf $(CONF)


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
	rm -rf  debian/linusmuster-client-extras


printer-default:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 printer/standarddrucker-nach-raum.sh $(BIN)
	@install -d -m755 -oroot -groot $(CONF)
	@install -oroot -groot --mode=0644 printer/printer-default.conf $(CONF)


italc:
	@echo '   * Installing italc scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 italc/italc-raumanpassung.sh $(BIN)
	@install -d -m755 -oroot -groot $(CONF)
	@install -oroot -groot --mode=0644 italc/leoclient-italc.conf $(CONF)


shutdown:
# no config file
	@echo '   * Installing shutdown script (without cronjob entry)'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 shutdown/herunterfahren.sh $(BIN)


icon-script:
	@echo '   * Installing desktop icons'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 desktop-icons/desktop-icons-hinzu.sh $(BIN)

