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

        self.currentDemonstrationFileId = -1;
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
    
    if (self.currentDemonstrationFileId != -1) {
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

- (void) demonstrate:(FileHandler *)fileHandler startPos:(double)startPos
{
    if (!fileHandler) {
        NSLog(@"No file handler provided");
        return;
    }
	
	if (self.currentDemonstrationFileId != -1) {
		[self stopDemonstration];
	}

    [self createWindow];
    if (fileHandler.fileType == SupportedFileTypeImage) {
        [self.demonstrationWindowController demonstrateImage:fileHandler.fileURL];
    } else if (fileHandler.fileType == SupportedFileTypeVideo) {
        [self.demonstrationWindowController demonstrateVideo:fileHandler.fileURL startPos:startPos];
    }

    self.currentDemonstrationFileId = fileHandler.fileId;
}

- (void) stopDemonstration
{
	[self.demonstrationWindowController stopDemonstration];
	[self.demonstrationWindowController close];
    self.currentDemonstrationFileId = -1;
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
