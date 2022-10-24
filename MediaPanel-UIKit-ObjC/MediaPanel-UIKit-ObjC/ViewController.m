//
//  ViewController.m
//  MediaPanel-UIKit-ObjC
//
//  Created by Rodrigo Sieiro on 2022-10-10.
//

@import AircoreMediaPanel;
#import "ViewController.h"

///For information and best practices on creating and using a Publishable API Key, please refer to docs (https://docs.aircore.io/key-concepts#apps-and-api-keys).
NSString *const kPublishableKey = @"INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD";
NSString *const kChannelID = @"sample-app";
NSString *const kPanelTitle = @"Objective-C Panel";

@interface ViewController ()

@property (nonatomic) AIRClient *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    NSString *userID = [NSUUID UUID].UUIDString;
    NSString *userName = [NSString stringWithFormat:@"User %@", [userID substringToIndex:5]];
    NSString *avatarUrl = [NSString stringWithFormat:@"https://i.pravatar.cc/300?u=%@", userID];

    // Option 1 : Use a Publishable API Key directly from the developer console
    self.client = [AIRClient createWithPublishableKey:kPublishableKey userID:userID];

    // Option 2 :Use a session auth token provided by your server by communication with the Aircores provisioning service using the Secret API key
    // self.client = [AIRClient createWithAuthToken:authToken userID:userID];

    // Choose a name and profile picture that will be used to show the user on the MediaPanel
    self.client.userDisplayName = userName;
    self.client.userAvatarURL = [NSURL URLWithString:avatarUrl];

    // Register event handlers for various events that are of interest for your host app
    [self.client on:AIRClientEventSessionAuthTokenInvalid handler:^(NSString * _Nonnull channelID, NSString * _Nonnull userID) {
        // Request a new token from the server
    }];

    // Register error handlers
    [self.client onErrorWithHandler:^(NSString * _Nullable channelID, NSError * _Nonnull error) {
        // Handle any errors
    }];

    // Last step after setting up client is to connect to your channel
    [self.client connectToChannelID:kChannelID];

    // Create a configuration object to configure various aspects of the MediaPanel. Refer docs
    AIRMediaPanelConfiguration *configuration = [AIRMediaPanelConfiguration defaultConfiguration];
    configuration.panelTitle = kPanelTitle;

    AIRMediaPanel *panel = [[AIRMediaPanel alloc] initWithClient:self.client
                                                       channelID:kChannelID
                                                   configuration:configuration // Try using [self customConfiguration] instead
                                                           theme:nil];  // Try using [self customTheme] instead

    [panel presentIn:self style:AIRMediaPanelStyleBottomBar];
}

// Create your own custom configuration and override the defaults provided by the SDK
- (AIRMediaPanelConfiguration *)customConfiguration {
    AIRMediaPanelStrings *strings = [[AIRMediaPanelStrings alloc] initWithJoinButton:@"Enter"
                                                                       joiningButton:@"Loading..."
                                                                   joinButtonTooltip:@"Tap to enter the conversation"
                                                                         leaveButton:@"Exit"
                                                                         retryButton:@"Retry"
                                                                      emptyCallTitle:@"No one is here"
                                                                   emptyCallSubtitle:@"Tap below to be the first"
                                                                  channelIsFullLabel:@"Channel is full"
                                                                   genericErrorLabel:@"Unknown Error"];

    AIRMediaPanelCollapsedStateOptions *collapsedOptions = [[AIRMediaPanelCollapsedStateOptions alloc] initWithMaxAvatars:4
                                                                                                               panelTitle:@"Collapsed Title"
                                                                                                            panelSubtitle:@"Collapsed Subtitle"
                                                                                                               joinButton:nil
                                                                                                            joiningButton:nil
                                                                                                              leaveButton:nil];

    AIRMediaPanelExpandedStateOptions *expandedOptions = [[AIRMediaPanelExpandedStateOptions alloc] initWithPanelTitle:@"Expanded Title"
                                                                                                         panelSubtitle:@"Expanded Subtitle"
                                                                                                            joinButton:nil
                                                                                                         joiningButton:nil
                                                                                                           leaveButton:nil];

    return [[AIRMediaPanelConfiguration alloc] initWithPanelTitle:@"My Panel Title"
                                                    panelSubtitle:@"My Panel Subtitle"
                                             showMicrophoneButton:YES
                                                          strings:strings
                                            collapsedStateOptions:collapsedOptions
                                             expandedStateOptions:expandedOptions];
}

//Create your own custom theme and override the defaults provided by the SDK
- (AIRTheme *)customTheme {
    return [[AIRTheme alloc] initWithBackgroundColor:[UIColor yellowColor]
                                        primaryColor:[UIColor blueColor]
                                         dangerColor:[UIColor redColor]
                                        borderRadius:24.0
                                         borderWidth:2.0
                                         borderColor:[UIColor greenColor]
                                          fontFamily:[UIFont fontWithName:@"Courier" size:20]
                                           textColor:[UIColor redColor]
                                        subtextColor:[UIColor greenColor]
                                primaryContrastColor:[UIColor darkGrayColor]
                                 dangerContrastColor:[UIColor purpleColor]
                                              avatar:[[AIRAvatar alloc] initWithBackground:[UIColor cyanColor]
                                                                               borderShape:[AIRBorderShape rounded:10]
                                                                                   spacing:10]
                                               icons:[[AIRIcons alloc] initWithParticipantsIcon:[UIImage new]
                                                                                  leaveCallIcon:[UIImage new]
                                                                                 micEnabledIcon:[UIImage new]
                                                                                micDisabledIcon:[UIImage new]
                                                                                   collapseIcon:[UIImage new]]];
}

@end
