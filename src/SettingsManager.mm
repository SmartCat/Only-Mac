#import "SettingsManager.h"

static NSString *const kLastMediaPathKey = @"LastMediaPath";

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

- (void)setLastMediaPath:(NSURL *)path {
    [_defaults setURL:path forKey:kLastMediaPathKey];
    [_defaults synchronize];
}

- (NSURL *)lastMediaPath {
	return [_defaults URLForKey:kLastMediaPathKey] ?: nil;
}

#pragma mark - General Settings


@end 
