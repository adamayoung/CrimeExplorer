fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios certs
```
fastlane ios certs
```
Fetches the provisioning profiles so you can build locally and deploy to your device
### ios test
```
fastlane ios test
```
Test
### ios build
```
fastlane ios build
```
Build
### ios build_and_sign
```
fastlane ios build_and_sign
```
Build and Sign
### ios beta
```
fastlane ios beta
```
Upload to TestFlight
### ios submit_review
```
fastlane ios submit_review
```
Submit to AppStore for Review

----

## Mac
### mac certs
```
fastlane mac certs
```
Fetches the provisioning profiles so you can build locally and deploy to your device
### mac test
```
fastlane mac test
```
Test
### mac build
```
fastlane mac build
```
Build
### mac build_and_sign
```
fastlane mac build_and_sign
```
Build and Sign

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
