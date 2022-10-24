
### MediaPanel SDK iOS Samples
The samples in this repo demonstrate how to use the Aircore MediaPanel SDK.  For more information, check out the [getting started guide](https://docs.aircore.io/getting-started/mediapanel-ios-getting-started) or the [API reference](https://docs.aircore.io/ios/mediapanel/api-reference)

#### [SwiftUI Sample](https://github.com/aircoreio/aircore-media-panel-ios-samples/tree/main/MediaPanel-SwiftUI)
#### [Swift Sample](https://github.com/aircoreio/aircore-media-panel-ios-samples/tree/main/MediaPanel-UIKit-Swift)
#### [Objective-C Sample](https://github.com/aircoreio/aircore-media-panel-ios-samples/tree/main/MediaPanel-UIKit-ObjC)

##### Setup
```
git clone https://github.com/aircoreio/aircore-media-panel-ios-samples.git
```
##### Launch
1. Ensure you have Xcode 13.3+ installed.
2. Open Finder and navigate to the directory where you checked out the code.
3. For the SwiftUI sample, launch aircore-media-panel-ios-samples -> MediaPanel-SwiftUI -> MediaPanel-SwiftUI.xcodeproj
4. For the Swift sample, launch aircore-media-panel-ios-samples -> MediaPanel-UIKit-Swift -> MediaPanel-UIKit-Swift.xcodeproj
5. For the Objective-C sample, launch aircore-media-panel-ios-samples -> MediaPanel-UIKit-ObjC -> MediaPanel-UIKit-ObjC.xcodeproj

#### Customization
1. From the Xcode Project Navigator, Open MediaPanel_SwiftUIApp.swift for the SwiftUI sample, ViewController.swift for the Swift sample, or ViewController.m for the Objective-C sample
2. Change these values as per your needs

##### SwiftUI/Swift  
```swift
let publishableKey = "INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD" // Replace with a Publishable API Key from the developer dashboard.
let userId = UUID.init().uuidString // Replace with any unique ID that represents your user in your system.
lazy var userName = "User " + userId.prefix(5) // Replace with any name that represents your user in your system.
lazy var userAvatarURL = URL(string: "https://i.pravatar.cc/300?u=" + userId) // Replace with a url for a profile picture that represents your user in your system.
let channel = "sample-app" // Replace with any unique name/id that represents a channel in your system.
```
##### Objective-C  
```objc
NSString *const kPublishableKey = @"INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD"; // Replace with a Publishable API Key from the developer dashboard.
NSString *userId = [NSUUID UUID].UUIDString; // Replace with any unique ID that represents your user in your system.
NSString *userName = [NSString stringWithFormat:@"User %@", [userId substringToIndex:5]]; // Replace with any name that represents your user in your system.
NSString *avatarUrl = [NSString stringWithFormat:@"https://i.pravatar.cc/300?u=%@", userId];  // Replace with a url for a profile picture that represents your user in your system.
NSString *const kChannelId = @"sample-app"; // Replace with any unique name/id that represents a channel in your system.
```

##### Running the Sample
1. Choose a simulator or an actual device (if you're running on a M1 mac)
2. Tap the ▷ button to run the sample