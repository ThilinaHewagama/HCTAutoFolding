//
//  HCTAutoFolding.h
//  HCTAutoFolding
//
//  Created by Thilina Hewagama on 9/6/15.
//  Copyright (c) 2015 Thilina Hewagama. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "xCodeHaders.h"

@class HCTAutoFolding;

static HCTAutoFolding *sharedPlugin;

@interface HCTAutoFolding : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end