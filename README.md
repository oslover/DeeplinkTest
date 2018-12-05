# DeeplinkTest
This is to demonstrate how to read and show the parameters from deeplink.

# Configuration

### Website configuration
- Open the apple-app-site-association file in SiteConfiguration folder with any Text Edition Tool.
- Replace the [APPLE_TEAM_ID] and [YOUR_APP_BUNDLE_ID] with yours. you can find them in the following links. 
  *Team ID - https://developer.apple.com/account/#/membership*  
  *Bundle ID - https://developer.apple.com/account/ios/identifier/bundle* 
- Deploy the apple-app-site-association file on the root directory of your website(i.e: www.appname.com).

### iOS app configuration
- Open the xcode project and select DeeplinkTest.entitlements file 
- change the [WEBSITE_LINK] to your website name(i.e: www.appname.com)

## That's it
:+1: Congratulations

# Final result
![](/Screenshot/deeplink_test.gif)


