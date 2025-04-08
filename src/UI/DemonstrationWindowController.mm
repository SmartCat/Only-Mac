//
//  NSWindowController+DemonstrationWindowController.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import "DemonstrationWindowController.h"

@implementation DemonstrationWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
	[self.window setBackgroundColor:[NSColor blackColor]];
    [self stopDemonstration];
}

- (void)demonstrateImage:(NSImage *)image
{
    self.imageView.hidden = NO;
    
    // Set the image
    self.imageView.image = image;
}

- (void)stopDemonstration
{
    self.imageView.hidden = YES;
}

@end
