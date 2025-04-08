#import <Cocoa/Cocoa.h>

@interface OperatorWindowController : NSWindowController

@property (nonatomic, strong) IBOutlet NSTableView *mediaTableView;
@property (strong) IBOutlet NSButton *btnSelectFolder;
@property (nonatomic, weak) IBOutlet NSTextField *monitorInfoLabel;
@property (nonatomic, weak) IBOutlet NSTextField *dirInfoLabel;
@property (nonatomic, weak) IBOutlet NSImageView *imgMonitorConnected;
@property (nonatomic, weak) IBOutlet NSImageView *imgMonitorDisconnected;

@property (nonatomic, strong) NSArray<NSURL *> *mediaFiles;
@property (nonatomic, strong) NSTimer *updateTimer;

- (IBAction)selectFolderClicked:(id)sender;
- (void) updateMediaList;

@end
