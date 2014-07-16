//
//  JSZoomableImageView.m
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

@import UIKit.UIImage;
@import UIKit.UIImageView;
@import UIKit.UITapGestureRecognizer;
@import QuartzCore.CALayer;

#import "JSZoomableImageView.h"
#import "UIImage+SizeOfFit.h"

@interface JSZoomableImageView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *testView;

@end

@implementation JSZoomableImageView

#pragma mark - Initialize
- (id)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setDelegate:self];
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setBouncesZoom:YES];
    [self setDecelerationRate:UIScrollViewDecelerationRateFast];
    [self setClipsToBounds:YES];
    [self setMaximumZoomScale:4.0];
    [self addSubview:self.imageView];

    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInOutGesture:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTapGesture];
}

#pragma mark - Override
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.isZommed && !CGRectEqualToRect(self.bounds, self.imageView.frame)) {
        CGRect imageViewFrame = [self.imageView.image frameOfFitInRect:self.bounds];
        [self.imageView setFrame:imageViewFrame];
        return;
    }

    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.imageView.frame;

    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2.0;
    }
    else {
        frameToCenter.origin.x = 0.0;
    }

    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2.0;
    }
    else {
        frameToCenter.origin.y = 0.0;
    }

    self.imageView.frame = frameToCenter;
}

#pragma mark - Gestures
- (void)zoomInOutGesture:(UITapGestureRecognizer *)recognizer
{
    if (self.image == nil) {
        return;
    }

    if (self.zoomScale != self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else {
        CGPoint touchPoint = [recognizer locationInView:self.imageView];
        CGFloat newZoomScale = (self.maximumZoomScale + self.minimumZoomScale) / 2;
        [self zoomToPoint:touchPoint withScale:newZoomScale animated:YES];
    }
}

- (void)zoomToPoint:(CGPoint)zoomPoint withScale: (CGFloat)scale animated: (BOOL)animated
{
    CGFloat xsize = self.bounds.size.width / scale;
    CGFloat ysize = self.bounds.size.height / scale;
    [self zoomToRect:CGRectMake(zoomPoint.x - xsize / 2, zoomPoint.y - ysize / 2, xsize, ysize) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - UIImageView
- (void)startAnimating
{
    [self.imageView startAnimating];
}

- (void)stopAnimating
{
    [self.imageView stopAnimating];
}

- (BOOL)isAnimating
{
    return [self.imageView isAnimating];
}

#pragma mark - Properties
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleToFill];
    }
    return _imageView;
}

- (BOOL)isZommed
{
    return self.zoomScale == self.minimumZoomScale ? NO : YES;
}

#pragma mark - UIImageView Properties
- (UIImage *)image { return self.imageView.image; }

- (void)setImage:(UIImage *)image { [self.imageView setImage:image]; }

- (UIImage *)highlightedImage { return self.imageView.highlightedImage; }

- (void)setHighlightedImage:(UIImage *)highlightedImage { [self.imageView setHighlightedImage:highlightedImage]; }

- (BOOL)isHighlighted { return [self.imageView isHighlighted]; }

- (void)setHighlighted:(BOOL)highlighted { [self.imageView setHighlighted:highlighted]; }

- (NSArray *)animationImages { return self.imageView.animationImages; }

- (void)setAnimationImages:(NSArray *)animationImages { [self.imageView setAnimationImages:animationImages]; }

- (NSArray *)highlightedAnimationImages { return self.imageView.highlightedAnimationImages; }

- (void)setHighlightedAnimationImages:(NSArray *)highlightedAnimationImages { [self.imageView setHighlightedAnimationImages:highlightedAnimationImages]; }

- (NSTimeInterval)animationDuration { return self.imageView.animationDuration; }

- (void)setAnimationDuration:(NSTimeInterval)animationDuration { [self.imageView setAnimationDuration:animationDuration]; }

- (NSInteger)animationRepeatCount { return self.imageView.animationRepeatCount; }

- (void)setAnimationRepeatCount:(NSInteger)animationRepeatCount { [self.imageView setAnimationRepeatCount:animationRepeatCount]; }

- (UIColor *)tintColor { return self.imageView.tintColor; }

- (void)setTintColor:(UIColor *)tintColor { [self.imageView setTintColor:tintColor]; }

@end
