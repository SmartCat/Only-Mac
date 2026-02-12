#import <Cocoa/Cocoa.h>

@interface SupportedFileTypes : NSObject

typedef NS_ENUM(NSInteger, SupportedFileType) {
    SupportedFileTypeImage,
    SupportedFileTypeVideo,
    SupportedFileTypeDocument,
	SupportedFileTypeWeb,

    SupportedFileTypeCount,
};

+ (NSArray<NSString *> *)getExtensionsForFileType:(SupportedFileType)fileType;
+ (SupportedFileType)getFileTypeForExtension:(NSString *)extension;

@end
