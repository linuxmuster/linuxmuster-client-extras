#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

CONF=$(DESTDIR)/etc/linuxmuster-client/extras
BIN=$(DESTDIR)/usr/bin
SBIN=$(DESTDIR)/usr/sbin
SHARE=$(DESTDIR)/usr/share/linuxmuster-client-extras

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make setup'
	@echo '      install script to setup end execute login scripts'
	@echo ' '
	@echo '   make watch-my-home'
	@echo '      install script to trigger alarm, when files/dirs are saved outside a dir'
	@echo ' '
	@echo '   make set-default-printer'
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


setup:
	@echo '   * Installing the setup and login scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 setup/linuxmuster-client-extras-login $(BIN)
	@install -d -m0755 -oroot -groot $(SBIN)
	@install -oroot -groot --mode=0755 setup/linuxmuster-client-extras-setup $(SBIN)
	@install -d -m0755 -oroot -groot $(SHARE)
	@install -oroot -groot --mode=0755 setup/linuxmuster-client-extras.desktop $(SHARE)


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


set-default-printer:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 printer/set-default-printer $(BIN)
	@install -d -m755 -oroot -groot $(CONF)
	@install -oroot -groot --mode=0644 printer/set-default-printer.conf $(CONF)


italc:
	@echo '   * Installing italc scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 italc/italc-raumanpassung.sh $(BIN)
	@install -d -m755 -oroot -groot $(CONF)
	@install -oroot -groot --mode=0644 italc/italc.conf $(CONF)


shutdown:
# no config file
	@echo '   * Installing shutdown script (without cronjob entry)'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 shutdown/herunterfahren.sh $(BIN)


icon-script:
	@echo '   * Installing desktop icons'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 desktop-icons/create-desktop-icons $(BIN)

