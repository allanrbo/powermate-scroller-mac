
APP_NAME = PowerMateScroll

SRC = main.m

OBJS = $(SRC:.m=.o)

CFLAGS = -framework Cocoa -framework IOKit -framework ApplicationServices


$(APP_NAME): $(OBJS)

	clang $(OBJS) -o $(APP_NAME) $(CFLAGS)

	$(MAKE) package


%.o: %.m

	clang -c $< -o $@


package:

	mkdir -p $(APP_NAME).app/Contents/MacOS

	mkdir -p $(APP_NAME).app/Contents/Resources

	cp $(APP_NAME) $(APP_NAME).app/Contents/MacOS/$(APP_NAME)

	@echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $(APP_NAME).app/Contents/Info.plist

	@echo "<!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> $(APP_NAME).app/Contents/Info.plist

	@echo "<plist version=\"1.0\">" >> $(APP_NAME).app/Contents/Info.plist

	@echo "<dict>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>CFBundleExecutable</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>$(APP_NAME)</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>CFBundleIdentifier</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>com.yourcompany.$(APP_NAME)</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>CFBundleName</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>$(APP_NAME)</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>CFBundleVersion</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>1.0</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>CFBundleShortVersionString</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>1.0</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <key>LSMinimumSystemVersion</key>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "    <string>10.10</string>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "</dict>" >> $(APP_NAME).app/Contents/Info.plist

	@echo "</plist>" >> $(APP_NAME).app/Contents/Info.plist


clean:

	rm -f $(OBJS) $(APP_NAME)

	rm -rf $(APP_NAME).app

