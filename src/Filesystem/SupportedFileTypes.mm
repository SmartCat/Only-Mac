#import "SupportedFileTypes.h"

@implementation SupportedFileTypes

+ (NSArray<NSString *> *)getExtensionsForFileType:(SupportedFileType)fileType {
    switch (fileType) {
        case SupportedFileTypeImage:
            return @[@"jpg", @"jpeg", @"png", @"gif", @"bmp", @"tiff", @"webp", @"heic", @"heif"];
        case SupportedFileTypeVideo:
            return @[@"mp4", @"mov", @"avi", @"mkv", @"wmv"];
        case SupportedFileTypeDocument:
            return @[@"pdf"];
		default:
			return @[];
    }
}
@end
