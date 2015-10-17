//
//  DOSNewLine.h
//  DOSNewLine
//
//  Created by 蘇聖傑 on 2015/10/17.
//  Copyright © 2015年 Dolphin. All rights reserved.
//

#import <AppKit/AppKit.h>

@class DOSNewLine;

static DOSNewLine *sharedPlugin;

@interface DOSNewLine : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end