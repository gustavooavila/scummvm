# Special target to create bundles for the GP2X Caanoo.

#bundle_name = release/scummvm-caanoo-`date '+%Y-%m-%d'`
bundle_name = release/scummvm-caanoo
f=$(shell which $(STRIP))
libloc = $(shell dirname $(f))

caanoo-bundle: $(EXECUTABLE) $(DIST_FILES_DOCS)
	$(MKDIR) "$(bundle_name)"
	$(MKDIR) "$(bundle_name)/scummvm"
	$(MKDIR) "$(bundle_name)/scummvm/saves"
	$(MKDIR) "$(bundle_name)/scummvm/engine-data"
	$(MKDIR) "$(bundle_name)/scummvm/lib"

	echo "Please put your save games in this dir" >> "$(bundle_name)/scummvm/saves/PUT_SAVES_IN_THIS_DIR"

	$(CP) $(srcdir)/dists/gph/caanoo/scummvm.gpe $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/scummvm.png $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/scummvmb.png $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/README-GPH $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/scummvm.ini $(bundle_name)/

	$(INSTALL) -c -m 644 $(DIST_FILES_DOCS) $(bundle_name)/scummvm/
	$(INSTALL) -c -m 644 $(DIST_FILES_THEMES) $(bundle_name)/scummvm/
ifdef DIST_FILES_ENGINEDATA
	$(INSTALL) -c -m 644 $(DIST_FILES_ENGINEDATA) $(bundle_name)/scummvm/engine-data
endif
ifdef DIST_FILES_NETWORKING
	$(INSTALL) -c -m 644 $(DIST_FILES_NETWORKING) $(bundle_name)/scummvm/
endif
ifdef DIST_FILES_VKEYBD
	$(INSTALL) -c -m 644 $(DIST_FILES_VKEYBD) $(bundle_name)/scummvm/
endif

	$(STRIP) $(EXECUTABLE) -o $(bundle_name)/scummvm/$(EXECUTABLE)

ifdef DYNAMIC_MODULES
	$(INSTALL) -d "$(bundle_name)/scummvm/plugins"
	$(INSTALL) -c -m 644 $(PLUGINS) "$(bundle_name)/scummvm/plugins"
	$(STRIP) $(bundle_name)/scummvm/plugins/*
endif

	tar -C $(bundle_name) -cvjf $(bundle_name).tar.bz2 .
	rm -R ./$(bundle_name)

caanoo-bundle-debug: $(EXECUTABLE) $(DIST_FILES_DOCS)
	$(MKDIR) "$(bundle_name)"
	$(MKDIR) "$(bundle_name)/scummvm"
	$(MKDIR) "$(bundle_name)/scummvm/saves"
	$(MKDIR) "$(bundle_name)/scummvm/engine-data"
	$(MKDIR) "$(bundle_name)/scummvm/lib"

	echo "Please put your save games in this dir" >> "$(bundle_name)/scummvm/saves/PUT_SAVES_IN_THIS_DIR"

	$(CP) $(srcdir)/dists/gph/caanoo/scummvm-gdb.gpe $(bundle_name)/scummvm/scummvm.gpe
	$(CP) $(srcdir)/dists/gph/scummvm.png $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/scummvmb.png $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/README-GPH $(bundle_name)/scummvm/
	$(CP) $(srcdir)/dists/gph/scummvm.ini $(bundle_name)/

	$(INSTALL) -c -m 644 $(DIST_FILES_DOCS) $(bundle_name)/scummvm/
	$(INSTALL) -c -m 644 $(DIST_FILES_THEMES) $(bundle_name)/scummvm/
ifdef DIST_FILES_ENGINEDATA
	$(INSTALL) -c -m 644 $(DIST_FILES_ENGINEDATA) $(bundle_name)/scummvm/engine-data
endif
ifdef DIST_FILES_NETWORKING
	$(INSTALL) -c -m 644 $(DIST_FILES_NETWORKING) $(bundle_name)/scummvm/
endif
ifdef DIST_FILES_VKEYBD
	$(INSTALL) -c -m 644 $(DIST_FILES_VKEYBD) $(bundle_name)/scummvm/
endif

	$(INSTALL) -c -m 777 $(srcdir)/$(EXECUTABLE) $(bundle_name)/scummvm/$(EXECUTABLE)

ifdef DYNAMIC_MODULES
	$(INSTALL) -d "$(bundle_name)/scummvm/plugins"
	$(INSTALL) -c -m 644 $(PLUGINS) "$(bundle_name)/scummvm/plugins"
endif

	tar -C $(bundle_name) -cvjf $(bundle_name)-debug.tar.bz2 .
	rm -R ./$(bundle_name)

.PHONY: caanoo-bundle caanoo-bundle-debug
