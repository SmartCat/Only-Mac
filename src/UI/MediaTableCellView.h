#import <Cocoa/Cocoa.h>
#import "SupportedFileTypes.h"
#import "FileHandler.h"
@interface MediaTableCellView : NSTableCellView

@property (nonatomic, weak) IBOutlet NSImageView *thumbnailView;
@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSButton *playButton;
@property (nonatomic, weak) IBOutlet NSButton *stopButton;
// video
@property (nonatomic, weak) IBOutlet NSTextField *currentVideoPosLabel;
@property (nonatomic, weak) IBOutlet NSTextField *totalVideoDurationLabel;
@property (nonatomic, weak) IBOutlet NSSlider *videoProgressIndicator;
// PDF
@property (nonatomic, weak) IBOutlet NSTextField *pdfPageLabel;
@property (nonatomic, weak) IBOutlet NSButton *pdfPrevPageButton;
@property (nonatomic, weak) IBOutlet NSButton *pdfNextPageButton;
// tags
@property (nonatomic, weak) IBOutlet NSImageView *tagImage;
@property (nonatomic, weak) IBOutlet NSImageView *tagVideo;
@property (nonatomic, weak) IBOutlet NSImageView *tagDocument;
@property (nonatomic, weak) IBOutlet NSImageView *tagWeb;

@property (nonatomic, weak) FileHandler *fileHandler;
@property (nonatomic, weak) NSTimer *updateTimer;

@property double videoDuration;
@property int pdfCurrentPageIdx;
@property int pdfPagesCount;

- (void)setupFromFileHandler:(FileHandler *)fileHandler;
- (NSString *)formatTime:(double)seconds;

- (IBAction)playClicked:(id)sender;
- (IBAction)stopClicked:(id)sender;
- (IBAction)pdfPrevPageClicked:(id)sender;
- (IBAction)pdfNextPageClicked:(id)sender;

@end
