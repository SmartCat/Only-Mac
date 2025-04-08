#import <Cocoa/Cocoa.h>

@interface EnumerateFilesHelper : NSObject

+ (NSArray<NSURL *> *)enumerateFilesInFolder:(NSURL *)folderURL;

@end

