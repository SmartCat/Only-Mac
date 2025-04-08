#import "SettingsManager.h"

static NSString *const kLastMediaPathKey = @"LastMediaPath";
static NSString *const kAutoPlayKey = @"AutoPlay";

@implementation SettingsManager {
    NSUserDefaults *_defaults;
}

+ (instancetype)sharedManager {
    static SettingsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SettingsManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - Media Settings

- (void)setLastMediaPath:(NSString *)path {
    [_defaults setObject:path forKey:kLastMediaPathKey];
    [_defaults synchronize];
}

- (NSString *)lastMediaPath {
    return [_defaults stringForKey:kLastMediaPathKey] ?: @"";
}

#pragma mark - General Settings

- (void)setAutoPlay:(BOOL)autoPlay {
    [_defaults setBool:autoPlay forKey:kAutoPlayKey];
    [_defaults synchronize];
}

- (BOOL)autoPlay {
    return [_defaults boolForKey:kAutoPlayKey];
}

@end 
