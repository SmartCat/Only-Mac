//
//  NSObject+DemonstrationManager.h
//  OnlyM-ac
//
//  Created by Dmitry Bushtets on 08.04.2025.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "FileHandler.h"

NS_ASSUME_NONNULL_BEGIN

@class DemonstrationWindowController;

@interface DemonstrationManager : NSObject

@property (nonatomic, strong) DemonstrationWindowController *demonstrationWindowController;
@property (nonatomic, strong) NSScreen *demoScreen;

@property int currentDemonstrationFileId;

+ (instancetype)sharedManager;

- (void)demonstrate:(FileHandler *)fileHandler startPos:(double)startPos;
- (void)stopDemonstration;

- (double) getCurrentVideoTime;

@end

NS_ASSUME_NONNULL_END
