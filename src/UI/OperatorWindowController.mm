#import "OperatorWindowController.h"
#import "MediaTableCellView.h"
#import "SelectFolderHelper.h"
#import "SettingsManager.h"
#import "EnumerateFilesHelper.h"
#import "DemonstrationManager.h"
#import "LocalizationManager.h"

@interface OperatorWindowController () <NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource>
@end

@implementation OperatorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.mediaTableView.delegate = self;
    self.mediaTableView.dataSource = self;
	self.mediaFileHandlers = [NSMutableArray array];
	self.imgMonitorConnected.hidden = YES;
	[self startUpdateTimer];
	
	[self updateMediaList];
}

- (IBAction)selectFolderClicked:(id)sender {
    [SelectFolderHelper selectFolder:^(void) {
        [self updateMediaList];
    }];
}

- (void)updateMediaList {
    NSURL *folderURL = [SettingsManager sharedManager].lastMediaPath;
    if (folderURL) {
		[self.mediaFileHandlers removeAllObjects];
        self.dirInfoLabel.stringValue = [folderURL absoluteString];
        NSArray<NSURL *> *fileUrls = [EnumerateFilesHelper enumerateFilesInFolder:folderURL];
        for (int i = 0; i < fileUrls.count; i++) {
            NSURL *fileUrl = fileUrls[i];
            FileHandler *fileHandler = [[FileHandler alloc] initWithFileId:i fileURL:fileUrl];
            [self.mediaFileHandlers addObject:fileHandler];
        }
		[self.mediaTableView reloadData];
		
		[[DemonstrationManager sharedManager] stopDemonstration];
    }
}

- (void)startUpdateTimer
{
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
}

- (void)updateUI:(NSTimer *)timer
{
    NSScreen *screen = [DemonstrationManager sharedManager].demoScreen;
    self.imgMonitorConnected.hidden = screen == nil;
    self.imgMonitorDisconnected.hidden = screen != nil;
    if (screen) {
		NSString *localizedLabel = [[LocalizationManager sharedManager] localizedStringForKey:@"operator_window.monitor"];
        self.monitorInfoLabel.stringValue = [NSString stringWithFormat:@"%@: %@", localizedLabel, screen.localizedName];
	} else {
		self.monitorInfoLabel.stringValue = [[LocalizationManager sharedManager] localizedStringForKey:@"operator_window.no_monitor"];
	}
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.mediaFileHandlers.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    MediaTableCellView *cellView = [tableView makeViewWithIdentifier:@"MediaTableCell" owner:self];
    
    if (row < self.mediaFileHandlers.count) {
        FileHandler *fileHandler = self.mediaFileHandlers[row];
        [cellView setupFromFileHandler:fileHandler];
    }
    
    return cellView;
}

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp terminate:self];
}

@end
