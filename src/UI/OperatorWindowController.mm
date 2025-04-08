#import "OperatorWindowController.h"

@interface OperatorWindowController () <NSTableViewDelegate, NSTableViewDataSource>
@end

@implementation OperatorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.mediaTableView.delegate = self;
    self.mediaTableView.dataSource = self;
    self.mediaTableView.rowHeight = 100; // Adjust based on your needs
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 0; // Update with actual data count
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MediaCell" owner:self];
    // Configure cell view here
    return cellView;
}

@end 
