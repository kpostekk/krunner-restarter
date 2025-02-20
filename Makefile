install:
	sudo mkdir -p /usr/local/bin
	sudo cp krunner-watch.sh /usr/local/bin/krunner-watch
	sudo chmod +x /usr/local/bin/krunner-watch
	mkdir -p ${HOME}/.config/systemd/user
	cp krunner-watch.service ${HOME}/.config/systemd/user/krunner-watch.service
	systemctl --user enable --now krunner-watch
uninstall:
	sudo rm /usr/local/bin/krunner-watch
	systemctl --user disable --now krunner-watch
	rm ${HOME}/.config/systemd/user/krunner-watch.service
