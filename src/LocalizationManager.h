#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalizationManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)localizedStringForKey:(NSString *)key;
- (NSString *)localizedStringForKey:(NSString *)key withComment:(nullable NSString *)comment;

@end

NS_ASSUME_NONNULL_END 
