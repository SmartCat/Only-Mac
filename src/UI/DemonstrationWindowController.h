//
//  NSWindowController+DemonstrationWindowController.h
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import <Cocoa/Cocoa.h>
#import <AVKit/AVKit.h>
#import <PDFKit/PDFKit.h>

@interface DemonstrationWindowController : NSWindowController

@property (nonatomic, weak) IBOutlet NSImageView *imageView;
@property (nonatomic, weak) IBOutlet AVPlayerView *videoView;
@property (nonatomic, weak) IBOutlet PDFView *pdfView;
@property (nonatomic, strong) AVPlayer *player;

- (void)demonstrateImage:(NSURL *)imageURL;
- (void)demonstrateVideo:(NSURL *)videoURL startPos:(double)startPos;
- (void)demonstrateDocument:(NSURL *)documentURL pageIdx:(int)pageIdx;
- (void)stopDemonstration;

- (double) getCurrentVideoTime;
- (int) getCurrentPage;

@end
