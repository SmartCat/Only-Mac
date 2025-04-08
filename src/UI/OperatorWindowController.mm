#import "OperatorWindowController.h"
#import "MediaTableCellView.h"
#import "SelectFolderHelper.h"
#import "SettingsManager.h"
#import "EnumerateFilesHelper.h"

@interface OperatorWindowController () <NSTableViewDelegate, NSTableViewDataSource>
@end

@implementation OperatorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.mediaTableView.delegate = self;
    self.mediaTableView.dataSource = self;
    //self.mediaTableView.rowHeight = 100; // Adjust based on your needs
	self.mediaFiles = @[];
}

- (IBAction)selectFolderClicked:(id)sender {
    [SelectFolderHelper selectFolder:^(void) {
        [self updateMediaList];
    }];
}

- (void)updateMediaList {
    NSURL *folderURL = [SettingsManager sharedManager].lastMediaPath;
    if (folderURL) {
        self.mediaFiles = [EnumerateFilesHelper enumerateFilesInFolder:folderURL];
        [self.mediaTableView reloadData];
    }
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.mediaFiles.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    MediaTableCellView *cellView = [tableView makeViewWithIdentifier:@"MediaTableCell" owner:self];
    
    if (row < self.mediaFiles.count) {
        NSURL *fileURL = self.mediaFiles[row];
        cellView.titleLabel.stringValue = fileURL.lastPathComponent;
        
        // Set thumbnail if it's an image
        if ([@[@"jpg", @"jpeg", @"png", @"gif", @"bmp", @"tiff", @"webp", @"heic", @"heif"] containsObject:fileURL.pathExtension.lowercaseString]) {
            NSImage *image = [[NSImage alloc] initWithContentsOfURL:fileURL];
            cellView.thumbnailView.image = image;
        }
        
        // Reset progress bar
        cellView.progressBar.doubleValue = 0;
        cellView.progressBar.hidden = YES;
    }
    
    return cellView;
}

@end
