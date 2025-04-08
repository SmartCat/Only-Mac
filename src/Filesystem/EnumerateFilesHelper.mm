#import "EnumerateFilesHelper.h"
#import "SupportedFileTypes.h"
@implementation EnumerateFilesHelper

+ (NSArray<NSURL *> *)enumerateFilesInFolder:(NSURL *)folderURL {
    if (!folderURL) {
        return @[];
    }
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray<NSURL *> *files = [fileManager contentsOfDirectoryAtURL:folderURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
    
    NSMutableArray<NSString *> *extensions = [NSMutableArray array];
    for (NSInteger i = 0; i < SupportedFileTypeCount; i++) {
        [extensions addObjectsFromArray:[SupportedFileTypes getExtensionsForFileType:SupportedFileType(i)]];
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension.lowercaseString IN %@", extensions];
    files = [files filteredArrayUsingPredicate:predicate];
    
	if (!error)
	{
		return files;
	}
	else
	{
		return @[];
	}
}

@end

