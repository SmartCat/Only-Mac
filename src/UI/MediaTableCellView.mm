#import <AVFoundation/AVFoundation.h>
#import <PDFKit/PDFKit.h>
#import "MediaTableCellView.h"
#import "DemonstrationManager.h"

@implementation MediaTableCellView

- (void)setupFromFileHandler:(FileHandler *)fileHandler {
	// Clean up previous state
	[self cleanup];
	
	self.fileHandler = fileHandler;
	self.titleLabel.stringValue = fileHandler.fileURL.lastPathComponent;
    
    [self hideOptionalStuff];

    if (self.fileHandler.fileType == SupportedFileTypeImage) {
        [self setupForImage:self.fileHandler.fileURL];
    } else if (self.fileHandler.fileType == SupportedFileTypeVideo) {
        [self setupForVideo:self.fileHandler.fileURL];
    } else if (self.fileHandler.fileType == SupportedFileTypeDocument) {
        [self setupForDocument:self.fileHandler.fileURL];
    }
	
	[self startUpdateTimer];
}

- (void)cleanup {
	// Stop and invalidate any existing timer
	[self.updateTimer invalidate];
	self.updateTimer = nil;
	
	// Clear any existing data
	self.fileHandler = nil;
	self.titleLabel.stringValue = @"";
	self.thumbnailView.image = nil;
	self.currentVideoPosLabel.stringValue = @"";
	self.totalVideoDurationLabel.stringValue = @"";
	self.videoProgressIndicator.doubleValue = 0;
	self.videoDuration = 0;
	self.pdfPageLabel.stringValue = @"";
	self.pdfCurrentPageIdx = 0;
	self.pdfPagesCount = 0;
	
	// Hide all optional UI elements
	[self hideOptionalStuff];
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self cleanup];
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
	self.pdfPageLabel.hidden = NO;
	self.pdfPrevPageButton.hidden = NO;
	self.pdfNextPageButton.hidden = NO;
	self.pdfPrevPageButton.enabled = NO;
	self.pdfNextPageButton.enabled = NO;
	
    PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
	self.pdfPagesCount = (int)document.pageCount;
    PDFPage *page = [document pageAtIndex:0];
    if (page) {
        NSImage *thumbnail = [page thumbnailOfSize:NSMakeSize(160.0, 120.0) forBox:kPDFDisplayBoxMediaBox];
        self.thumbnailView.image = thumbnail;
    }
	
	[self updatePdfUI];
}

- (void)hideOptionalStuff
{
    self.currentVideoPosLabel.hidden = YES;
    self.totalVideoDurationLabel.hidden = YES;
    self.videoProgressIndicator.hidden = YES;
	self.stopButton.hidden = YES;
	
	self.pdfPageLabel.hidden = YES;
	self.pdfPrevPageButton.hidden = YES;
	self.pdfNextPageButton.hidden = YES;

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
	if (self.fileHandler.fileType == SupportedFileTypeImage)
	{
		[[DemonstrationManager sharedManager] demonstrate:self.fileHandler startPos:0.0];
	}
	else if (self.fileHandler.fileType == SupportedFileTypeVideo)
	{
		double startPos = self.videoProgressIndicator.doubleValue;
		[[DemonstrationManager sharedManager] demonstrate:self.fileHandler startPos:startPos];
	}
	else if (self.fileHandler.fileType == SupportedFileTypeDocument)
	{
		[[DemonstrationManager sharedManager] demonstrate:self.fileHandler startPos:self.pdfCurrentPageIdx];
	}
}

- (IBAction)stopClicked:(id)sender
{
 	[[DemonstrationManager sharedManager] stopDemonstration];
}

- (IBAction)pdfPrevPageClicked:(id)sender
{
	self.pdfCurrentPageIdx--;
	[self updatePdfUI];
	[[DemonstrationManager sharedManager] updateDemonstration:self.fileHandler startPos:self.pdfCurrentPageIdx];
}

- (IBAction)pdfNextPageClicked:(id)sender
{
	self.pdfCurrentPageIdx++;
	[self updatePdfUI];
	[[DemonstrationManager sharedManager] updateDemonstration:self.fileHandler startPos:self.pdfCurrentPageIdx];
}

- (IBAction)videoProgressChanged:(id)sender
{
    double currentTime = self.videoProgressIndicator.doubleValue;
    self.currentVideoPosLabel.stringValue = [self formatTime:currentTime];
}

- (void)startUpdateTimer
{
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    BOOL isDemonstrating = [DemonstrationManager sharedManager].currentDemonstrationFileId == self.fileHandler.fileId;

    if (isDemonstrating && self.fileHandler.fileType == SupportedFileTypeVideo) {
        // Update video progress
		double currentVideoTime = [[DemonstrationManager sharedManager] getCurrentVideoTime];
		self.videoProgressIndicator.doubleValue = currentVideoTime;
        self.currentVideoPosLabel.stringValue = [self formatTime:currentVideoTime];
    }
	
	if (isDemonstrating && self.fileHandler.fileType == SupportedFileTypeDocument) {
		self.pdfCurrentPageIdx = [[DemonstrationManager sharedManager] getCurrentPage];
		[self updatePdfUI];
	}
    
	self.playButton.hidden = isDemonstrating;
    self.stopButton.hidden = !isDemonstrating;
	
}

- (void) updatePdfUI
{
	self.pdfPageLabel.stringValue = [NSString stringWithFormat:@"%d/%d", self.pdfCurrentPageIdx+1, self.pdfPagesCount];
	self.pdfPrevPageButton.enabled = self.pdfCurrentPageIdx > 0;
	self.pdfNextPageButton.enabled = (self.pdfCurrentPageIdx+1) < self.pdfPagesCount;
}

@end 
