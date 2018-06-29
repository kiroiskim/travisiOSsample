release:
	mkdir -p $UNIVERSAL_OUTPUTFOLDER
	xcodebuild -target "travisiOSsample" -configuration Release ONLY_ACTIVE_ARCH=NO -sdk iphoneos  BUILD_DIR=$BUILD_DIR clean build
	xcodebuild -target "travisiOSsample" -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR=$BUILD_DIR clean build
	cp -R $BUILD_DIR/Release-iphoneos/travisiOSsample.framework $UNIVERSAL_OUTPUTFOLDER/
	cp -R $BUILD_DIR/Release-iphonesimulator/travisiOSsample.framework/Modules/travisiOSsample.swiftmodule/. $UNIVERSAL_OUTPUTFOLDER/travisiOSsample.framework/Modules/travisiOSsample.swiftmodule
	lipo -create -output $UNIVERSAL_OUTPUTFOLDER/travisiOSsample.framework/travisiOSsample $BUILD_DIR/Release-iphonesimulator/travisiOSsample.framework/travisiOSsample $BUILD_DIR/Release-iphoneos/travisiOSsample.framework/travisiOSsample
	mv $UNIVERSAL_OUTPUTFOLDER/travisiOSsample.framework .
	tar -cvzf travisiOSsample-iOS-$XCODE_VER.tar.gz travisiOSsample.framework
	mkdir releases
	mv travisiOSsample-iOS-*.tar.gz releases/
