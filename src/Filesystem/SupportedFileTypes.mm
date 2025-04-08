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

+ (SupportedFileType)getFileTypeForExtension:(NSString *)extension {
	for (NSInteger i = 0; i < SupportedFileTypeCount; i++) {
		NSArray<NSString *> *extensions = [self getExtensionsForFileType:SupportedFileType(i)];
		if ([extensions containsObject:extension.lowercaseString]) {
			return SupportedFileType(i);
		}
	}
	return SupportedFileTypeCount;
}

@end
