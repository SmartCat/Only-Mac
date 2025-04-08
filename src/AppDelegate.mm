//
//  AppDelegate.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 07.04.2025.
//

#import "AppDelegate.h"
#import "OperatorWindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Create and configure the button
	NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(20, 20, 200, 30)];
	[button setTitle:@"Open Window on Another Monitor"];
	[button setButtonType:NSButtonTypeMomentaryPushIn];
	[button setBezelStyle:NSBezelStyleRounded];
	[button setTarget:self];
	[button setAction:@selector(openWindowOnAnotherMonitor:)];
	
	// Add the button to the window's content view
	//[self.window.contentView addSubview:button];
	self.operatorWindowController = [[OperatorWindowController alloc] initWithWindowNibName:@"OperatorWindow"];
	[self.operatorWindowController showWindow:nil];
}

- (IBAction)openWindowOnAnotherMonitor:(id)sender {
	// Get all available screens
	NSArray<NSScreen *> *screens = [NSScreen screens];
	
	// If there's only one screen, show an alert
	if (screens.count <= 1) {
		NSAlert *alert = [[NSAlert alloc] init];
		[alert setMessageText:@"No additional monitors found"];
		[alert setInformativeText:@"Please connect another monitor to use this feature."];
		[alert addButtonWithTitle:@"OK"];
		[alert runModal];
		return;
	}
	
	// Find the first screen that's not the main screen
	NSScreen *targetScreen = nil;
	for (NSScreen *screen in screens) {
		if (screen != [NSScreen mainScreen]) {
			targetScreen = screen;
			break;
		}
	}
	
	if (targetScreen) {
		// Create a new window
		NSWindow *newWindow = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 400, 300)
														 styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable
														   backing:NSBackingStoreBuffered
															 defer:NO];
		
		// Position the window on the target screen
		NSRect screenFrame = targetScreen.frame;
		NSRect windowFrame = newWindow.frame;
		NSPoint windowOrigin = NSMakePoint(
			screenFrame.origin.x + (screenFrame.size.width - windowFrame.size.width) / 2,
			screenFrame.origin.y + (screenFrame.size.height - windowFrame.size.height) / 2
		);
		[newWindow setFrameOrigin:windowOrigin];
		
		// Set window properties
		[newWindow setTitle:@"New Window"];
		[newWindow makeKeyAndOrderFront:nil];
	}
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
	return YES;
}

@end
