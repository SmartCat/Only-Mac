#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsManager : NSObject

+ (instancetype)sharedManager;

// Media settings
- (void)setLastMediaPath:(NSURL *)path;
- (NSURL *)lastMediaPath;

// General settings

@end

NS_ASSUME_NONNULL_END 
