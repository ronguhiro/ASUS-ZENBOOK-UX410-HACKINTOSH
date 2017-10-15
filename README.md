# ASUS-ZENBOOK-UX410-DSDT-PATCH
A collection of DSDT/SSDT patches and tools for the ASUS UX401 laptop for macOS 10.12.6

#### What you should expect works

* Audio
* Keyboard and touchpad
* Battery
* Fn-keys
* Brightness
* Sleep
* Bluetooth
* WiFi when replaced (tested: Dell DW1560 WiFi)

#### Will never work

* Factory Intel WiFi card.

## Notes:

To make trackpad work, remove these kexts from /System/Library/Extensions/:
* AppleHPM.kext
* AppleIntelLpssI2C.kext
* AppleIntelLpssI2CController.kext

## To-Do

* Create automatic scripts
* Test HDMI audio

## Credits

@gulios (see https://www.tonymacx86.com/threads/asus-ux430ua-kaby-lake-intel-hd-graphics-620.225847) 

@Shinji3rd (see https://www.tonymacx86.com/threads/guide-asus-zenbook-ux310uak-macos-sierra-installation-guide.224591)

@alexandred for the the touchpad driver.

@RehabMan for everything else