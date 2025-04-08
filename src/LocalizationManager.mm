#import "LocalizationManager.h"

@implementation LocalizationManager

+ (instancetype)sharedManager {
	static LocalizationManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[LocalizationManager alloc] init];
	});
	return sharedInstance;
}

- (NSString *)localizedStringForKey:(NSString *)key {
	return [self localizedStringForKey:key withComment:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key withComment:(nullable NSString *)comment {
	return NSLocalizedStringFromTable(key, @"Localizable", comment);
}

@end 
