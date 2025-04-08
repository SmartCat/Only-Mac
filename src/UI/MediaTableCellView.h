#import <Cocoa/Cocoa.h>

@interface MediaTableCellView : NSTableCellView

@property (nonatomic, weak) IBOutlet NSImageView *thumbnailView;
@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSTextField *durationLabel;
@property (nonatomic, weak) IBOutlet NSButton *playButton;
@property (nonatomic, weak) IBOutlet NSProgressIndicator *progressBar;

@end 