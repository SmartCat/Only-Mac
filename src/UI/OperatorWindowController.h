#import <Cocoa/Cocoa.h>

@interface OperatorWindowController : NSWindowController

@property (nonatomic, strong) IBOutlet NSTableView *mediaTableView;
@property (strong) IBOutlet NSButton *btnSelectFolder;
@property (nonatomic, strong) NSArray<NSURL *> *mediaFiles;

- (IBAction)selectFolderClicked:(id)sender;
- (void) updateMediaList;

@end
