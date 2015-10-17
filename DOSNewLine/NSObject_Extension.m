//
//  NSObject_Extension.m
//  DOSNewLine
//
//  Created by 蘇聖傑 on 2015/10/17.
//  Copyright © 2015年 Dolphin. All rights reserved.
//


#import "NSObject_Extension.h"
#import "DOSNewLine.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[DOSNewLine alloc] initWithBundle:plugin];
        });
    }
}
@end
