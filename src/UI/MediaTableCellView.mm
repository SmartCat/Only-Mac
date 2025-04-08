#import "MediaTableCellView.h"

@implementation MediaTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.playButton.wantsLayer = YES;
    self.playButton.layer.cornerRadius = 20;
    self.playButton.layer.backgroundColor = [NSColor purpleColor].CGColor;
    
    self.progressBar.style = NSProgressIndicatorBarStyle;
}

@end 