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
        
        // Set up screen change observation
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(screenDidChange:)
													 name:NSApplicationDidChangeScreenParametersNotification
												   object:nil];
        
        [self updateDemoScreen];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)screenDidChange:(NSNotification *)notification
{
    [self updateDemoScreen];
    
    if (self.isDemonstrationInProgress) {
        [self stopDemonstration];
    }
}

- (void)updateDemoScreen
{
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

- (void) demonstrateImage:(NSURL *)imageURL
{
    if (!imageURL) {
        NSLog(@"No image URL provided");
        return;
    }
    
    [self createWindow];
    
    [self.demonstrationWindowController demonstrateImage:imageURL];
    self.isDemonstrationInProgress = YES;
}

- (void) demonstrateVideo:(NSURL *)videoURL startPos:(double)startPos
{
    if (!videoURL) {
        NSLog(@"No video URL provided");
        return;
    }
    
    [self createWindow];
    
    [self.demonstrationWindowController demonstrateVideo:videoURL startPos:startPos];
    self.isDemonstrationInProgress = YES;
}

- (void) stopDemonstration
{
	[self.demonstrationWindowController stopDemonstration];
	[self.demonstrationWindowController close];
    self.isDemonstrationInProgress = NO;
}

- (void) createWindow
{
    NSRect windowFrame;
    if (self.demoScreen) {
        NSRect screenFrame = self.demoScreen.frame;
        windowFrame = NSMakeRect(screenFrame.origin.x, screenFrame.origin.y,
                                screenFrame.size.width, screenFrame.size.height);
    } else {
        // Single monitor/Debug
        windowFrame = NSMakeRect(600, 240, 480, 270);
    }
    
    [self.demonstrationWindowController showWindow:nil];
    [self.demonstrationWindowController.window setFrame:windowFrame display:YES];
}

- (double) getCurrentVideoTime
{
    return [self.demonstrationWindowController getCurrentVideoTime];
}

@end
