RELEASE_VERSION_MAJOR = 2
RELEASE_VERSION_MINOR = 1

RELEASE_FILES = ihex.py nxpprog.py README
RELEASE_BASE_NAME = nxpprog

RELEASE_NAME = $(RELEASE_BASE_NAME)_$(RELEASE_VERSION_MAJOR)_$(RELEASE_VERSION_MINOR)
RELEASE_NOTE = RELEASE_$(RELEASE_VERSION_MAJOR)_$(RELEASE_VERSION_MINOR)
RELEASE_FILES += $(RELEASE_NOTE)

release:
	rm -fr uploads
	mkdir uploads
	tar -cjvf uploads/$(RELEASE_NAME).tar.bz2 $(RELEASE_FILES)
	zip uploads/$(RELEASE_NAME).zip $(RELEASE_FILES)
	cp $(RELEASE_NOTE) uploads
	cp $(RELEASE_NOTE) uploads/README

clean:
	rm -fr uploads