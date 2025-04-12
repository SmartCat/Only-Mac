#import <Cocoa/Cocoa.h>
#import "SupportedFileTypes.h"

@interface FileHandler : NSObject

@property (nonatomic, assign) int fileId;
@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, assign) SupportedFileType fileType;

- (id)initWithFileId:(int)fileId fileURL:(NSURL *)fileURL;

@end

