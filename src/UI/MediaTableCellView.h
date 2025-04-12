#import <Cocoa/Cocoa.h>
#import "SupportedFileTypes.h"
#import "FileHandler.h"
@interface MediaTableCellView : NSTableCellView

@property (nonatomic, weak) IBOutlet NSImageView *thumbnailView;
@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSTextField *currentVideoPosLabel;
@property (nonatomic, weak) IBOutlet NSTextField *totalVideoDurationLabel;
@property (nonatomic, weak) IBOutlet NSButton *playButton;
@property (nonatomic, weak) IBOutlet NSButton *stopButton;
@property (nonatomic, weak) IBOutlet NSSlider *videoProgressIndicator;
// tags
@property (nonatomic, weak) IBOutlet NSImageView *tagImage;
@property (nonatomic, weak) IBOutlet NSImageView *tagVideo;
@property (nonatomic, weak) IBOutlet NSImageView *tagDocument;

@property (nonatomic, weak) FileHandler *fileHandler;
@property (nonatomic, weak) NSTimer *updateTimer;

@property double videoDuration;

- (void)setupFromFileHandler:(FileHandler *)fileHandler;
- (NSString *)formatTime:(double)seconds;

- (IBAction)playClicked:(id)sender;
- (IBAction)stopClicked:(id)sender;

@end
