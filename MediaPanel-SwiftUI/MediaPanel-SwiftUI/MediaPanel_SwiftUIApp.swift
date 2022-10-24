//
//  MediaPanel_SwiftUIApp.swift
//  MediaPanel-SwiftUI
//
//  Created by Deepak on 10/12/22.
//

import SwiftUI
import AircoreMediaPanel

@main
struct MediaPanel_SwiftUIApp: App {
    var client: Client
    var panel: MediaPanel

    init() {
        //For information and best practices on creating and using a Publishable API Key, please refer to docs (https://docs.aircore.io/key-concepts#apps-and-api-keys).
        let publishableKey = "INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD"
        //An unique id that represents you user
        let userID = UUID.init().uuidString
        //A name that represents you user that is visible on the MediaPanel
        let userName = "User " + userID.prefix(5)
        //A profile picture that represents you user that is visible on the MediaPanel
        let userAvatarURL = URL(string: "https://i.pravatar.cc/300?u=" + userID)
        //An unique id that represents your channel for the other users to join
        let channelID = "sample-app"

        // Option 1 : Use a Publishable API Key directly from the developer console
        client = Client.create(publishableKey: publishableKey, userID: userID)

        // Option 2 :Use a session auth token provided by your server by communication with the Aircore's provisioning service using the Secret API key
        //client = Client.create(authToken: authToken, userId: userId)

        // Choose a name and profile picture that will be used to show the user on the MediaPanel
        client.userDisplayName = userName
        client.userAvatarURL = userAvatarURL

        // Register event handlers for various events that are of interest for your host app. For a full list of events, refer to the ClientEvent enum.
        client.on(.sessionAuthTokenInvalid) { channelID, userID in
            //Request a new token from the server
        }

        // Register error handlers
        client.onError { channelID, error in
            //Handle any errors
        }

        // Last step after setting up client is to connect to your channel
        client.connect(channelID: channelID)

        // Create a configuration object to configure various aspects of the MediaPanel. Refer docs
        let configuration = MediaPanelConfiguration()

        // Create a MediaPanel object using the client and configuation and optional theme.
        panel = MediaPanel(client: client,
                           channelID: channelID,
                           configuration: configuration, // Try using customConfig() instead
                           theme: nil // Try using customTheme() instead
        )
    }

    var body: some Scene {
        WindowGroup {
            // Pass the panel to the view that will show the collapsed bar
            ContentView(panel: panel)
        }
    }

    //Create your own custom configuration and override the defaults provided by the SDK
    func customConfig() -> MediaPanelConfiguration {
        MediaPanelConfiguration(
            panelTitle: "My Panel Title",
            panelSubtitle: "My Panel Subtitle",
            showMicrophoneButton: true,
            strings: customStrings(),
            collapsedStateOptions: MediaPanelConfiguration.CollapsedStateOptions(
                maxAvatars: 3,
                panelTitle: "Collapsed Title",
                panelSubtitle: "Collapsed Title",
                joinButton: "Connect",
                joiningButton: "Connecting...",
                leaveButton: "Disconnect"
            ),
            expandedStateOptions: MediaPanelConfiguration.ExpandedStateOptions(
                panelTitle: "Expanded Title",
                panelSubtitle: "Expanded Title",
                joinButton: "Enter",
                joiningButton: "Entering...",
                leaveButton: "Leave"
            )
        )
    }

    //Create your own custom strings configuration and override the defaults provided by the SDK
    func customStrings() -> MediaPanelConfiguration.Strings {
        MediaPanelConfiguration.Strings(
            joinButton: "Join",
            joiningButton: "Joining..",
            joinButtonTooltip: "Tap Join to start the audio session",
            leaveButton: "Leave",
            retryButton: "Retry",
            emptyCallTitle: "No one is on the call yet.",
            emptyCallSubtitle: "Tap Join below to be the first!",
            channelIsFullLabel: "The channel is full",
            genericErrorLabel: "Something went wrong..."
        )
    }

    //Create your own custom theme and override the defaults provided by the SDK
    func customTheme() -> Theme {
        Theme(
            backgroundColor: UIColor.yellow,
            primaryColor: .blue,
            dangerColor: UIColor.red,
            borderRadius: 24,
            borderWidth: 2,
            borderColor: .green,
            fontFamily: .init(name: "Courier", size: 20)!,
            textColor: .red,
            subtextColor: UIColor.green,
            primaryContrastColor: .darkGray,
            dangerContrastColor: UIColor.purple,
            avatar: Theme.Avatar(
                background: .cyan,
                borderShape: Theme.BorderShape.rounded(10),
                spacing: 10),
            icons: Theme.Icons(
                participantsIcon: .init(),
                leaveCallIcon: .init(),
                micEnabledIcon: .init(),
                micDisabledIcon: .init(),
                collapseIcon: .init())
        )
    }
}
