# ghostty-focus — install the GNOME Shell extension and helper script

UUID        := ghostty-raise@local
EXT_SRC     := ghostty-focus@local
SCRIPT      := ghostty-raise

EXT_DIR     := $(HOME)/.local/share/gnome-shell/extensions/$(UUID)
BIN_DIR     := $(HOME)/.local/bin

.PHONY: all install install-extension install-script enable disable uninstall

all: install

## Install both the extension and the helper script
install: install-extension install-script
	@echo
	@echo "Installed. Enable the extension with: make enable"
	@echo "(On Wayland you must log out and back in for GNOME Shell to pick it up.)"

## Copy the extension into the GNOME Shell extensions directory
install-extension:
	@echo "Installing extension to $(EXT_DIR)"
	rm -rf "$(EXT_DIR)"
	mkdir -p "$(EXT_DIR)"
	cp -r $(EXT_SRC)/. "$(EXT_DIR)/"

## Copy the helper script into ~/.local/bin and make it executable
install-script:
	@echo "Installing $(SCRIPT) to $(BIN_DIR)"
	mkdir -p "$(BIN_DIR)"
	cp $(SCRIPT) "$(BIN_DIR)/$(SCRIPT)"
	chmod +x "$(BIN_DIR)/$(SCRIPT)"

## Enable the extension
enable:
	gnome-extensions enable $(UUID)

## Disable the extension
disable:
	-gnome-extensions disable $(UUID)

## Remove the extension and helper script
uninstall: disable
	rm -rf "$(EXT_DIR)"
	rm -f "$(BIN_DIR)/$(SCRIPT)"
	@echo "Uninstalled."
