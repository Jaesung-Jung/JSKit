//
//  UIView+Properties.m
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

#import "UIView+Properties.h"

@implementation UIView (Properties)

#pragma mark - Frame Getter
- (CGPoint)frameOrigin
{
    return self.frame.origin;
}

- (CGFloat)frameX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)frameY
{
    return CGRectGetMinY(self.frame);
}

- (CGSize)frameSize
{
    return self.frame.size;
}

- (CGFloat)frameWidth
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)frameHeight
{
    return CGRectGetHeight(self.frame);
}

#pragma mark - Frame Setter
- (void)setFrameOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setFrameX:(CGFloat)x
{
    self.frame = CGRectMake(x, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setFrameY:(CGFloat)y
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setFrameSize:(CGSize)size
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, size.height);
}

- (void)setFrameWidth:(CGFloat)width
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, CGRectGetHeight(self.frame));
}

- (void)setFrameHeight:(CGFloat)height
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
}

#pragma mark - Bounds Getter
- (CGPoint)boundsOrigin
{
    return self.bounds.origin;
}

- (CGFloat)boundsX
{
    return CGRectGetMinX(self.bounds);
}

- (CGFloat)boundsY
{
    return CGRectGetMinY(self.bounds);
}

- (CGSize)boundsSize
{
    return self.bounds.size;
}

- (CGFloat)boundsWidth
{
    return CGRectGetWidth(self.bounds);
}

- (CGFloat)boundsHeight
{
    return CGRectGetHeight(self.bounds);
}

#pragma mark - Bounds Setter
- (void)setBoundsOrigin:(CGPoint)origin
{
    self.bounds = CGRectMake(origin.x, origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setBoundsX:(CGFloat)x
{
    self.bounds = CGRectMake(x, CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setBoundsY:(CGFloat)y
{
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setBoundsSize:(CGSize)size
{
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), size.width, size.height);
}

- (void)setBoundsWidth:(CGFloat)width
{
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), width, CGRectGetHeight(self.bounds));
}

- (void)setBoundsHeight:(CGFloat)height
{
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), height);
}

@end
