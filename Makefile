# This requires GNU Make. 

ifeq (${prefix}, ) 	# If no prefix set by user, use /usr/local/*/
  prefix=/usr/local
endif

ifeq (${bindir}, ) 	# Allow `bindir=~/bin make install` to force directory
  SPACEPATH=$(subst :, ,${PATH})
  # Prefer installing in ~/bin so we don't need sudo.
  temp=$(filter ${HOME}/bin /usr/local/bin, ${SPACEPATH})
  bindir=$(word 1,${temp})
  # Ideally, we'd check for writability of dirs here, but how?
endif

ifeq (${bindir}, )      # Failsafe if bindir didn't get set above
  bindir=$(prefix)/bin
endif

usage:
	@if [ ! -w "${bindir}" ]; then MAYBESUDO="sudo "; fi ;\
	echo "Type '$${MAYBESUDO}make install' to install Zool to ${bindir}."
	@echo "Type 'make uninstall' to remove it."
	@echo
	@echo "To install in a different directory, "
	@echo "type 'make bindir=/some/other/directory install'."
	@echo
install:
	cp -a zool ${bindir}
	cp -a zool.desktop ${HOME}/.local/share/applications/
	-xdg-mime default ${HOME}/.local/share/applications/zool.desktop x-scheme-handler/zoommtg
	-gio mime x-scheme-handler/zoommtg zool.desktop
	-update-desktop-database ~/.local/share/applications
	@if xdg-mime query default x-scheme-handler/zoommtg | grep -s zool;\
	then\
	  echo "All done!" ;\
	else \
	  echo "Oops, something went wrong.Running: " ;\
	  echo "  xdg-mime query default x-scheme-handler/zoommtg" ;\
	  echo "ought to say zool.desktop, but instead it says" ;\
	  echo -n "'" ;\
	  xdg-mime query default x-scheme-handler/zoommtg ;\
	  echo -n "'" ;\
	fi


uninstall:
	rm -f ${HOME}/.local/share/applications/zool.desktop
	rm -f /usr/local/bin/zool
	xdg-mime query default x-scheme-handler/zoommtg
