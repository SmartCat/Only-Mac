#import <Cocoa/Cocoa.h>

@interface SupportedFileTypes : NSObject

typedef NS_ENUM(NSInteger, SupportedFileType) {
    SupportedFileTypeImage,
    SupportedFileTypeVideo,
    SupportedFileTypeDocument,

    SupportedFileTypeCount,
};

+ (NSArray<NSString *> *)getExtensionsForFileType:(SupportedFileType)fileType;

@end

