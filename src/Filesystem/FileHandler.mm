#import "FileHandler.h"

@implementation FileHandler

- (id)initWithFileId:(int)fileId fileURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        self.fileId = fileId;
        self.fileURL = fileURL;
        self.fileType = [SupportedFileTypes getFileTypeForExtension:fileURL.pathExtension];
    }
    return self;
}
@end
