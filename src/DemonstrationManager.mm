//
//  NSObject+DemonstrationManager.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import "DemonstrationManager.h"
#import "DemonstrationWindowController.h"

@implementation DemonstrationManager

+ (instancetype)sharedManager
{
    static DemonstrationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DemonstrationManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialize the demonstration window
        self.demonstrationWindowController = [[DemonstrationWindowController alloc] initWithWindowNibName:@"DemonstrationWindow"];
        
        NSArray<NSScreen *> *screens = [NSScreen screens];
        // Find the first screen that's not the main screen
        // TODO: Get screen from settings
        for (NSScreen *screen in screens) {
            if (screen != [NSScreen mainScreen]) {
                self.demoScreen = screen;
                break;
            }
        }
    }
    return self;
}

- (void) demonstrateImage:(NSURL *)imageURL
{
    if (!imageURL) {
        NSLog(@"No image URL provided");
        return;
    }
    
    NSRect windowFrame;
    if (self.demoScreen) {
        NSRect screenFrame = self.demoScreen.frame;
        windowFrame = NSMakeRect(screenFrame.origin.x, screenFrame.origin.y,
                                screenFrame.size.width, screenFrame.size.height);
    } else {
        // Single monitor/Debug
        windowFrame = NSMakeRect(800, 240, 480, 270);
    }
    
    [self.demonstrationWindowController showWindow:nil];
    [self.demonstrationWindowController.window setFrame:windowFrame display:YES];
    
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
    if (!image) {
        NSLog(@"Failed to load image from URL: %@", imageURL);
        return;
    }
    
    [self.demonstrationWindowController demonstrateImage:image];
    self.isDemonstrationInProgress = YES;
}

- (void) stopDemonstration
{
	[self.demonstrationWindowController close];
    self.isDemonstrationInProgress = NO;
}

@end
