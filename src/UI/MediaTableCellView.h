#import <Cocoa/Cocoa.h>
#import "SupportedFileTypes.h"

@interface MediaTableCellView : NSTableCellView

@property (nonatomic, weak) IBOutlet NSImageView *thumbnailView;
@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSTextField *currentVideoPosLabel;
@property (nonatomic, weak) IBOutlet NSTextField *totalVideoDurationLabel;
@property (nonatomic, weak) IBOutlet NSButton *playButton;
@property (nonatomic, weak) IBOutlet NSSlider *videoProgressIndicator;
// tags
@property (nonatomic, weak) IBOutlet NSImageView *tagImage;
@property (nonatomic, weak) IBOutlet NSImageView *tagVideo;
@property (nonatomic, weak) IBOutlet NSImageView *tagDocument;

@property double videoDuration;

- (void)setupFromURL:(NSURL *)url;
- (NSString *)formatTime:(double)seconds;

@end
