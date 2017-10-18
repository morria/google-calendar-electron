.PHONY: all clean npm

s+ = $(subst \ ,+,$1)
+s = $(subst +,\ ,$1)

all: $(call s+,target/Google Calendar.dmg)

clean:
	rm -rf target
	rm -rf node_modules

npm:
	npm install
	npm install electron-packager -g

$(call s+,target/Google\ Calendar-darwin-x64/Google\ Calendar.app): npm target/assets/icons/mac/google_calendar.icns package.json main.js
	mkdir -p target/
	electron-packager . "Google Calendar" \
		--overwrite \
		--platform=darwin \
		--arch=x64 \
		--icon=target/assets/icons/mac/google_calendar.icns \
		--prune=true \
		--version-string.ProductName="Google Calendar" \
		--osx-sign \
		--protocol calendar \
		--out=target

target/assets/icons/mac/google_calendar.icns: src/google_calendar.iconset
	mkdir -p target/assets/icons/mac/
	iconutil -c icns ./src/google_calendar.iconset -o target/assets/icons/mac/google_calendar.icns

$(call s+,target/Google Calendar.dmg): $(call s+,target/Google\ Calendar-darwin-x64/Google\ Calendar.app)
	hdiutil create \
		-volname "Google Calendar" \
		-srcfolder "target/Google Calendar-darwin-x64" \
		-ov \
		-format UDZO \
		"target/Google Calendar.dmg"
