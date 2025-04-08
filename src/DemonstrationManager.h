//
//  NSObject+DemonstrationManager.h
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class DemonstrationWindowController;

@interface DemonstrationManager : NSObject

@property (nonatomic, strong) DemonstrationWindowController *demonstrationWindowController;
@property (nonatomic, strong) NSScreen *demoScreen;

+ (instancetype)sharedManager;

- (void)demonstrateImage:(NSURL *)imageURL;
- (void)demonstrateVideo:(NSURL *)videoURL;
- (void)demonstrateDocument:(NSURL *)documentURL;

- (void)stopDemonstration;

@end

NS_ASSUME_NONNULL_END
