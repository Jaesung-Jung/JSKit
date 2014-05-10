//
//  UIView+Properties.h
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

@import UIKit.UIView;

@interface UIView (Properties)

#pragma mark - Frame
@property (nonatomic) CGPoint frameOrigin NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat frameX NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat frameY NS_AVAILABLE_IOS(2_0);

@property (nonatomic) CGSize  frameSize NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat frameWidth NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat frameHeight NS_AVAILABLE_IOS(2_0);

#pragma mark Bounds
@property (nonatomic) CGPoint boundsOrigin NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat boundsX NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat boundsY NS_AVAILABLE_IOS(2_0);

@property (nonatomic) CGSize  boundsSize NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat boundsWidth NS_AVAILABLE_IOS(2_0);
@property (nonatomic) CGFloat boundsHeight NS_AVAILABLE_IOS(2_0);

@end
