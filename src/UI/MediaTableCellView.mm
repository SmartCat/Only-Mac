#import "MediaTableCellView.h"

@implementation MediaTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressBar.style = NSProgressIndicatorBarStyle;
}

@end 
