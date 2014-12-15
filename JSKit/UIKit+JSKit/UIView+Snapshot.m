//
//  UIView+Snapshot.m
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

@import UIKit.UIGraphics;

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshot
{
    return [self snapshotWithFrame:self.frame scale:0.0];
}

- (UIImage *)snapshotWithFrame:(CGRect)frame
{
    return [self snapshotWithFrame:frame scale:0.0];
}

- (UIImage *)snapshotWithScale:(CGFloat)scale
{
    return [self snapshotWithFrame:self.frame scale:scale];
}

- (UIImage *)snapshotWithFrame:(CGRect)frame scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    [self drawViewHierarchyInRect:CGRectMake(-frame.origin.x, -frame.origin.y, self.frame.size.width, self.frame.size.height) afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return snapshot;
}

- (UIImage *)snapshotWithFrame:(CGRect)frame snapshotSize:(CGSize)snapshotSize
{
    return [self snapshotWithFrame:frame snapshotSize:snapshotSize scale:0.0];
}

- (UIImage *)snapshotWithFrame:(CGRect)frame snapshotSize:(CGSize)snapshotSize scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    [self drawViewHierarchyInRect:CGRectMake(-frame.origin.x, -frame.origin.y, snapshotSize.width, snapshotSize.height) afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
