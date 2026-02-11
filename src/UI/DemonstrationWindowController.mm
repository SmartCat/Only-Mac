//
//  NSWindowController+DemonstrationWindowController.m
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import "DemonstrationWindowController.h"
#import <AVKit/AVKit.h>
#import <PDFKit/PDFKit.h>

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
    self.pdfView.hidden = YES;
    
    // Set the image
    self.imageView.image = [[NSImage alloc] initWithContentsOfURL:imageURL];
}

- (void)demonstrateVideo:(NSURL *)videoURL startPos:(double)startPos
{
    self.imageView.hidden = YES;
	self.videoView.hidden = NO;
    self.pdfView.hidden = YES;
    
    // Create and configure AVPlayer
    self.player = [[AVPlayer alloc] initWithURL:videoURL];
    self.videoView.player = self.player;
    
    // Start playback
	[self.player seekToTime:CMTimeMakeWithSeconds(startPos, 600)];
    [self.player play];
    
    // Add observer for playback completion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)demonstrateDocument:(NSURL *)documentURL pageIdx:(int)pageIdx
{
    self.imageView.hidden = YES;
    self.videoView.hidden = YES;
    self.pdfView.hidden = NO;
	
	// Configure pdf viewer
	self.pdfView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	self.pdfView.autoScales = YES;
	self.pdfView.displayMode = kPDFDisplaySinglePage;
	self.pdfView.displayDirection = kPDFDisplayDirectionVertical;
	
	// Display document page
    PDFDocument *document = [[PDFDocument alloc] initWithURL:documentURL];
	self.pdfView.document = document;
	if (pageIdx >= 0 && pageIdx < document.pageCount)
	{
		PDFPage *page = [document pageAtIndex:pageIdx];
		[self.pdfView goToPage:page];
	}
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
	self.pdfView.document = nil;
    self.imageView.hidden = YES;
	self.videoView.hidden = YES;
	self.pdfView.hidden = YES;
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

- (int) getCurrentPage
{
	if (self.pdfView.hidden || self.pdfView.document == nil || self.pdfView.currentPage == nil) {
		return -1;
	}
	return (int)[self.pdfView.document indexForPage:self.pdfView.currentPage];
}

@end
