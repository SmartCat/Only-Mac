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
@property (nonatomic, weak) IBOutlet AVPlayerView *videoView;
@property (nonatomic, strong) AVPlayer *player;

- (void)demonstrateImage:(NSURL *)imageURL;
- (void)demonstrateVideo:(NSURL *)videoURL startPos:(double)startPos;
- (void)stopDemonstration;

- (double) getCurrentVideoTime;

@end

