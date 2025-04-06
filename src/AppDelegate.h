//
//  AppDelegate.h
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 07.04.2025.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) IBOutlet NSWindow *window;

- (IBAction)openWindowOnAnotherMonitor:(id)sender;

@end

