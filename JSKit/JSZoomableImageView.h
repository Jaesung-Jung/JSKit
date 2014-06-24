//
//  JSZoomableImageView.h
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

@import UIKit.UIScrollView;

@interface JSZoomableImageView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage NS_AVAILABLE_IOS(3_0);      // default is nil

@property (nonatomic, readonly) BOOL isZommed;

@property (nonatomic, getter=isHighlighted) BOOL highlighted NS_AVAILABLE_IOS(3_0); // default is NO

// these allow a set of images to be animated. the array may contain multiple copies of the same
@property(nonatomic, copy) NSArray *animationImages;            // The array must contain UIImages. Setting hides the single image. default is nil
@property(nonatomic, copy) NSArray *highlightedAnimationImages NS_AVAILABLE_IOS(3_0);            // The array must contain UIImages. Setting hides the single image. default is nil

@property(nonatomic) NSTimeInterval animationDuration;         // for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
@property(nonatomic) NSInteger      animationRepeatCount;      // 0 means infinite (default is 0)

// When tintColor is non-nil, any template images set on the image view will be colorized with that color.
// The tintColor is inherited through the superview hierarchy. See UIView for more information.
@property (nonatomic, strong) UIColor *tintColor NS_AVAILABLE_IOS(7_0);

/*!
 * Starts animating the images in the receiver.
 */
- (void)startAnimating;

/*!
 * Stops animating the images in the receiver.
 */
- (void)stopAnimating;

/*!
 * Returns a Boolean value indicating whether the animation is running.
 *
 * @return YES if the animation is running; otherwise, NO.
 */
- (BOOL)isAnimating;

@end
