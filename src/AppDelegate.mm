//
//  AppDelegate.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 07.04.2025.
//

#import "AppDelegate.h"
#import "OperatorWindowController.h"
#import "SelectFolderHelper.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	self.operatorWindowController = [[OperatorWindowController alloc] initWithWindowNibName:@"OperatorWindow"];
	[self.operatorWindowController showWindow:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
	return YES;
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

- (IBAction)menuOpenClicked:(id)sender {
	[SelectFolderHelper selectFolder:^(void) {
		[self.operatorWindowController updateMediaList];
	}];
}

@end
