//
//  NSWindowController+DemonstrationWindowController.h
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import <Cocoa/Cocoa.h>
#import <AVKit/AVKit.h>

@interface DemonstrationWindowController : NSWindowController

@property (nonatomic, weak) IBOutlet NSImageView *imageView;
//@property (nonatomic, weak) IBOutlet AVPlayerView *videoView;

- (void)demonstrateImage:(NSImage *)image;
- (void)stopDemonstration;

@end

