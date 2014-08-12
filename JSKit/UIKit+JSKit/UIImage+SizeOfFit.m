//
//  UIImage+SizeOfFit.m
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

#import "UIImage+SizeOfFit.h"

@implementation UIImage (SizeOfFit)

- (CGSize)sizeOfFitAtWidth:(CGFloat)width
{
    CGFloat ratio = self.size.width / width;
    return CGSizeMake(width, self.size.height / ratio);
}

- (CGSize)sizeOfFitAtHeight:(CGFloat)height
{
    CGFloat ratio = self.size.height / height;
    return CGSizeMake(self.size.width / ratio, height);
}

- (CGRect)frameOfFitInRect:(CGRect)rect
{
    CGSize size = [self sizeOfFitAtWidth:rect.size.width];
    if (size.height > rect.size.height) {
        size = [self sizeOfFitAtHeight:rect.size.height];
    }

    CGPoint center = CGPointMake((rect.size.width - size.width) / 2.0,
                                 (rect.size.height - size.height) / 2.0);

    return CGRectMake(center.x, center.y, size.width, size.height);
}

@end
