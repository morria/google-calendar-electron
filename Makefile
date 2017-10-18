.PHONY: all clean npm

all: target/google-calendar-darwin-x64/google-calendar.app

clean:
	rm -rf target
	rm -rf node_modules

npm:
	npm install
	npm install electron-packager -g

target/google-calendar-darwin-x64/google-calendar.app: npm target/assets/icons/mac/google_calendar.icns package.json main.js
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
