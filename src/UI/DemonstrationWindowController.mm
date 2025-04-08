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
    
    // Configure window
    [self.window setStyleMask:NSWindowStyleMaskBorderless];
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor clearColor]];
    [self.window setLevel:NSFloatingWindowLevel];
}

- (void)demonstrateImage:(NSImage *)image
{
    if (!image) {
        NSLog(@"No image provided");
        return;
    }
    
    self.imageView.hidden = NO;
    
    // Set the image
    self.imageView.image = image;
}

@end
