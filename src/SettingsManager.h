#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsManager : NSObject

+ (instancetype)sharedManager;

// Media settings
- (void)setLastMediaPath:(NSString *)path;
- (NSString *)lastMediaPath;

// General settings
- (void)setAutoPlay:(BOOL)autoPlay;
- (BOOL)autoPlay;

@end

NS_ASSUME_NONNULL_END 
