#import <Cocoa/Cocoa.h>
#import "FileHandler.h"
@interface OperatorWindowController : NSWindowController

@property (nonatomic, weak) IBOutlet NSTableView *mediaTableView;
@property (nonatomic, weak) IBOutlet NSButton *btnSelectFolder;
@property (nonatomic, weak) IBOutlet NSTextField *monitorInfoLabel;
@property (nonatomic, weak) IBOutlet NSTextField *dirInfoLabel;
@property (nonatomic, weak) IBOutlet NSImageView *imgMonitorConnected;
@property (nonatomic, weak) IBOutlet NSImageView *imgMonitorDisconnected;

@property (nonatomic, strong) NSMutableArray<FileHandler *> *mediaFileHandlers;
@property (nonatomic, weak) NSTimer *updateTimer;

- (IBAction)selectFolderClicked:(id)sender;
- (void) updateMediaList;

@end
