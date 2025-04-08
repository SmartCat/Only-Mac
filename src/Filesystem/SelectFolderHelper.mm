#import <Cocoa/Cocoa.h>

#import "SelectFolderHelper.h"
#import "SettingsManager.h"

@implementation SelectFolderHelper

+ (void)selectFolder:(void(^)(void))completionHandler {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanCreateDirectories:YES];

    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSURL *selectedURL = panel.URL;
            if (selectedURL) {
                [[SettingsManager sharedManager] setLastMediaPath: selectedURL];
            }
        }
        if (completionHandler) {
            completionHandler();
        }
    }];
}

@end

