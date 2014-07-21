//
//  JSKit.h
//
//  Copyright (c) 2014 Jaesung Jung
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

// Foundation+JSKit
#import "Foundation+JSKit/NSDate+String.h"
#import "Foundation+JSKit/NSDate+String.h"
#import "Foundation+JSKit/NSObject+Associated.h"
#import "Foundation+JSKit/NSString+CharacterCount.h"

// UIKit+JSkit
#import "UIKit+JSKit/NSLayoutConstraint+Creation.h"
#import "UIKit+JSKit/UIColor+Colors.h"
#import "UIKit+JSKit/UIControl+Event.h"
#import "UIKit+JSKit/UIImage+BlurEffects.h"
#import "UIKit+JSKit/UIImage+Color.h"
#import "UIKit+JSKit/UIView+Animation.h"
#import "UIKit+JSKit/UIView+Properties.h"
#import "UIKit+JSKit/UIView+Snapshot.h"

// JSKit
#import "JSAnimationStep.h"
#import "JSCircularImageView.h"
#import "JSZoomableImageView.h"
#import "JSZipArchive.h"

// Device interface idiom
#define DEVICE_IS_PHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define DEVICE_IS_PAD   UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define XCODE_COLORS_PLUGIN     1
#if XCODE_COLORS_PLUGIN
// How to apply color formatting to your log statements:
//
// To set the foreground color:
// Insert the ESCAPE_SEQ into your string, followed by "fg124,12,255;" where r=124, g=12, b=255.
//
// To set the background color:
// Insert the ESCAPE_SEQ into your string, followed by "bg12,24,36;" where r=12, g=24, b=36.
//
// To reset the foreground color (to default value):
// Insert the ESCAPE_SEQ into your string, followed by "fg;"
//
// To reset the background color (to default value):
// Insert the ESCAPE_SEQ into your string, followed by "bg;"
//
// To reset the foreground and background color (to default values) in one operation:
// Insert the ESCAPE_SEQ into your string, followed by ";"

// #define XCODE_COLORS_ESCAPE_MAC @"\033["
// #define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["
//
// #if TARGET_OS_IPHONE
// #define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
// #else
// #define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_IOS
// #endif
#define XCODE_COLORS_ESCAPE    @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg165,200,255;" @"%s(%d)/D: " fmt XCODE_COLORS_RESET), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define ILog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg185,255,150;" @"%s(%d)/I: " fmt XCODE_COLORS_RESET), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define WLog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,200,0;"   @"%s(%d)/W: " fmt XCODE_COLORS_RESET), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define ELog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,80,127;"  @"%s(%d)/E: " fmt XCODE_COLORS_RESET), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define DLog(...)
    #define ILog(...)
    #define WLog(...)
    #define ELog(...)
#endif

#else // XCODE_COLORS_PLUGIN
#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s(%d)/D: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define ELog(fmt, ...) NSLog((@"%s(%d)/E: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define ILog(fmt, ...) NSLog((@"%s(%d)/I: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define WLog(fmt, ...) NSLog((@"%s(%d)/W: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define DLog(...)
    #define ELog(...)
    #define ILog(...)
    #define WLog(...)
#endif

#endif
