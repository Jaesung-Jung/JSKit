//
//  UIImage+SizeOfFit.m
//  JSKit
//
//  Created by 정재성 on 2014. 6. 24..
//  Copyright (c) 2014년 Jaesung Jung. All rights reserved.
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
