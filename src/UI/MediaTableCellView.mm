#import "MediaTableCellView.h"
#import <AVFoundation/AVFoundation.h>

@implementation MediaTableCellView

- (void)setupFromURL:(NSURL *)url {
    self.titleLabel.stringValue = url.lastPathComponent;
    
    [self hideOptionalStuff];

    NSString *extension = url.pathExtension.lowercaseString;
    SupportedFileType fileType = [SupportedFileTypes getFileTypeForExtension:extension];
    
    if (fileType == SupportedFileTypeImage) {
        [self setupForImage:url];
    } else if (fileType == SupportedFileTypeVideo) {
        [self setupForVideo:url];
    } else if (fileType == SupportedFileTypeDocument) {
        [self setupForDocument:url];
    }
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

@end 
