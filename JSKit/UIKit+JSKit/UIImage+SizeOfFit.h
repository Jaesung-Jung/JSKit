//
//  UIImage+SizeOfFit.h
//  JSKit
//
//  Created by 정재성 on 2014. 6. 24..
//  Copyright (c) 2014년 Jaesung Jung. All rights reserved.
//

@import UIKit.UIImage;

@interface UIImage (SizeOfFit)

/*!
 * Returns the size of fit using given width.
 *
 * @params width Calculate the width.
 *
 * @return Size of fit at width.
 */
- (CGSize)sizeOfFitAtWidth:(CGFloat)width;

/*!
 * Returns the size of fit using given height.
 *
 * @params height Calculate the height.
 *
 * @return Size of fit at height.
 */
- (CGSize)sizeOfFitAtHeight:(CGFloat)height;

/*!
 * Returns frame size of fit the size for rect.
 *
 * @params rect Calculate the rect.
 *
 * @return Frame of fit in rect.
 */
- (CGRect)frameOfFitInRect:(CGRect)rect;

@end
