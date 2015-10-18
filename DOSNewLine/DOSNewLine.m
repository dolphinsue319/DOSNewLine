//
//  DOSNewLine.m
//  DOSNewLine
//
//  Created by 蘇聖傑 on 2015/10/17.
//  Copyright © 2015年 Dolphin. All rights reserved.
//

#import "DOSNewLine.h"
#import <DTXcodeHeaders.h>
#import <DTXcodeUtils.h>
#import <MASShortcut/Shortcut.h>
#import <Carbon/Carbon.h>

@interface DOSNewLine()
@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation DOSNewLine

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        //using shift+command+enter to trigger action
        MASShortcut *shortcut = [MASShortcut shortcutWithKeyCode:kVK_Return modifierFlags:NSShiftKeyMask|NSCommandKeyMask];
        [[MASShortcutMonitor sharedMonitor] registerShortcut:shortcut withAction:^{
            [self doAction];
        }];
    }
    return self;
}

// Sample Action, for menu item:
- (void)doAction
{
    // This is a reference to the current source code editor.
    DVTSourceTextView *sourceTextView = [DTXcodeUtils currentSourceTextView];
    NSRange range = [sourceTextView selectedRanges][0].rangeValue;
    __autoreleasing NSString *contentString = [sourceTextView string];
    NSRange thisRange = [self findRangeWithNewLine:range targetString:contentString];
    if (thisRange.location == NSNotFound) {
        return;
    }
    NSString *replaceMent = [NSString stringWithFormat:@";\n"];
    if ([self isThisSwiftFile]) {
        replaceMent = [NSString stringWithFormat:@"\n"];
    }
    [sourceTextView insertText:replaceMent replacementRange:thisRange];
    [sourceTextView setSelectedRange:NSMakeRange(thisRange.location+1, 0)];
}
-(BOOL)isThisSwiftFile{
    NSString *fileType = [DTXcodeUtils currentSourceCodeDocument].fileType;
    return [fileType containsString:@"swift"];
}
//public.objective-c-source
-(NSRange)findRangeWithNewLine:(NSRange)beginRange targetString:(NSString *)targetString{
    NSRange range = [targetString rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]
                                                  options:NSLiteralSearch
                                                    range:NSMakeRange(beginRange.location, targetString.length - beginRange.location)];
    return range;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
