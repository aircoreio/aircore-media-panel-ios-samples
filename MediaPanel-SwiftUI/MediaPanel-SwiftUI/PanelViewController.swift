//
//  PanelViewController.swift
//  sample
//
//  Created by Deepak on 10/5/22.
//

import UIKit
import AircoreMediaPanel


class PanelViewController: UIViewController {

    ///For information and best practices on creating and using a Publishable API Key, please refer to docs (https://docs.aircore.io/key-concepts#apps-and-api-keys).
    let key = "INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD"
    let userId = UUID.init().uuidString
    lazy var userName = "User " + userId.prefix(5)
    lazy var userAvatarURL = URL(string: "https://i.pravatar.cc/300?u=" + userId)
    let channel = "sample-app"

    private var client: Client?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Option 1 : Use a Publishable API Key directly from the developer console
        let client = Client.create(publishableKey: key, userID: userId)

        // Option 2 :Use a session auth token provided by your server by communication with the Aircores provisioning service using the Secret API key
        //let client = Client.create(authToken: authToken, userId: userId)

        // Choose a name and profile picture that will be used to show the user on the MediaPanel
        client.userDisplayName = userName
        client.userAvatarURL = userAvatarURL

        // Register event handlers for various events that are of interest for your host app
        client.on(.sessionAuthTokenInvalid) { channelId, userId in
            //Request the server for a new token
        }

        // Last step after setting up client is to connect to your channel
        client.connect(channelID: channel)
        self.client = client

        // Create a configuration object to configure various aspects of the MediaPanel. Refer docs
        let configuration = MediaPanelConfiguration()

        let panel = MediaPanel(client: client,
                               channelID: channel,
                               configuration: configuration, // Try using customConfig() instead
                               theme: nil // Try using customTheme() instead
        )
        panel.present(in: self, style: .bottomBar)
    }


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

    func customStrings() -> MediaPanelConfiguration.Strings {
        let stringsConfig = MediaPanelConfiguration.Strings()
        stringsConfig.joinButton = "Join"
        stringsConfig.joiningButton = "Joining.."
        stringsConfig.joinButtonTooltip = "Tap Join to start the audio session"
        stringsConfig.leaveButton = "Leave"
        stringsConfig.retryButton = "Retry"
        stringsConfig.emptyCallTitle = "No one is on the call yet."
        stringsConfig.emptyCallSubtitle = "Tap Join below to be the first!"
        stringsConfig.channelIsFullLabel = "The channel is full"
        stringsConfig.genericErrorLabel = "Something went wrong..."
        return stringsConfig
    }

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
