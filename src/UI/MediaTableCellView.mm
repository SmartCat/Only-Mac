#import <AVFoundation/AVFoundation.h>
#import "MediaTableCellView.h"
#import "DemonstrationManager.h"

@implementation MediaTableCellView

- (void)setupFromURL:(NSURL *)url {
	self.fileUrl = url;
	self.isDemonstrating = NO;
    self.titleLabel.stringValue = url.lastPathComponent;
    
    [self hideOptionalStuff];

    NSString *extension = url.pathExtension.lowercaseString;
    self.fileType = [SupportedFileTypes getFileTypeForExtension:extension];
    
    if (self.fileType == SupportedFileTypeImage) {
        [self setupForImage:url];
    } else if (self.fileType == SupportedFileTypeVideo) {
        [self setupForVideo:url];
    } else if (self.fileType == SupportedFileTypeDocument) {
        [self setupForDocument:url];
    }
	
	[self startUpdateTimer];
}

- (void)setupForImage:(NSURL *)url
{
    self.tagImage.hidden = NO;
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
    self.thumbnailView.image = image;
}

- (void)setupForVideo:(NSURL *)url
{
    self.tagVideo.hidden = NO;
    self.currentVideoPosLabel.hidden = NO;
    self.totalVideoDurationLabel.hidden = NO;
    self.videoProgressIndicator.hidden = NO;
    
    // Get video duration
    AVAsset *asset = [AVAsset assetWithURL:url];
    CMTime duration = asset.duration;
    self.videoDuration = CMTimeGetSeconds(duration);
    
    // Format duration as MM:SS
    self.currentVideoPosLabel.stringValue = [self formatTime:0.0];
    self.totalVideoDurationLabel.stringValue = [self formatTime:self.videoDuration];

    // Set slider values
	self.videoProgressIndicator.maxValue = self.videoDuration;
    
    // Generate thumbnail
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // Get thumbnail from the middle of the video
    CMTime time = CMTimeMakeWithSeconds(self.videoDuration/2, 600);
    NSError *error = nil;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:&error];
    
    if (error == nil) {
        NSImage *thumbnail = [[NSImage alloc] initWithCGImage:imageRef size:NSZeroSize];
        self.thumbnailView.image = thumbnail;
        CGImageRelease(imageRef);
	} else {
		NSLog(@"Error generating thumbnail: %@", error);
	}
}

- (void)setupForDocument:(NSURL *)url
{
    self.tagDocument.hidden = NO;
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
    //self.thumbnailView.image = image;
}

- (void)hideOptionalStuff
{
    self.currentVideoPosLabel.hidden = YES;
    self.totalVideoDurationLabel.hidden = YES;
    self.videoProgressIndicator.hidden = YES;
	self.stopButton.hidden = YES;

    self.tagImage.hidden = YES;
    self.tagVideo.hidden = YES;
    self.tagDocument.hidden = YES;
}

- (NSString *)formatTime:(double)seconds
{
    int minutes = (int)seconds / 60;
    int remainingSeconds = (int)seconds % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, remainingSeconds];
}

- (IBAction)playClicked:(id)sender
{
	self.isDemonstrating = YES;
    self.playButton.hidden = YES;
    self.stopButton.hidden = NO;
	[[DemonstrationManager sharedManager] demonstrateImage:self.fileUrl];
}

- (IBAction)stopClicked:(id)sender
{
    self.isDemonstrating = NO;
    self.playButton.hidden = NO;
    self.stopButton.hidden = YES;
	[[DemonstrationManager sharedManager] stopDemonstration];
}

- (void)startUpdateTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    if (self.isDemonstrating) {
        // Update video progress
        //self.videoProgressIndicator.doubleValue = currentTime;
    }
    
	self.playButton.enabled = ![[DemonstrationManager sharedManager] isDemonstrationInProgress];
}

@end 
