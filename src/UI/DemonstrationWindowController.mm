//
//  NSWindowController+DemonstrationWindowController.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import "DemonstrationWindowController.h"
#import <AVKit/AVKit.h>

@implementation DemonstrationWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
	[self.window setBackgroundColor:[NSColor blackColor]];
    [self stopDemonstration];
}

- (void)demonstrateImage:(NSURL *)imageURL
{
    self.imageView.hidden = NO;
	self.videoView.hidden = YES;
    
    // Set the image
    self.imageView.image = [[NSImage alloc] initWithContentsOfURL:imageURL];
}

- (void)demonstrateVideo:(NSURL *)videoURL startPos:(double)startPos
{
    self.imageView.hidden = YES;
	self.videoView.hidden = NO;
    
    // Create and configure AVPlayer
    self.player = [[AVPlayer alloc] initWithURL:videoURL];
    self.videoView.player = self.player;
    
    // Start playback
	[self.player seekToTime:CMTimeMakeWithSeconds(startPos, 600)];
    [self.player play];
    
    // Add observer for playback completion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    [self stopDemonstration];
}

- (void)stopDemonstration
{
    if (self.player) {
        [self.player pause];
        self.player = nil;
    }
    self.imageView.hidden = YES;
	self.videoView.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (double) getCurrentVideoTime
{
    if (self.videoView.hidden || !self.player) {
        return 0.0;
    }
    return CMTimeGetSeconds(self.player.currentTime);
}

@end
