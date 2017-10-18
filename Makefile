.PHONY: all clean

all: target/google-calendar-darwin-x64/google-calendar.app

clean:
	rm -rf target
	rm -rf node_modules

target/google-calendar-darwin-x64/google-calendar.app: target/assets/icons/mac/google_calendar.icns
	npm install
	npm install electron-packager -g
	mkdir -p target/
	electron-packager . --overwrite --platform=darwin --arch=x64 --icon=target/assets/icons/mac/google_calendar.icns --prune=true --out=target

target/assets/icons/mac/google_calendar.icns: src/google_calendar.iconset
	mkdir -p target/assets/icons/mac/
	iconutil -c icns ./src/google_calendar.iconset -o target/assets/icons/mac/google_calendar.icns
