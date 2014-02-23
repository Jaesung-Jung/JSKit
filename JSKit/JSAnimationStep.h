//
//  JSAnimationStep.h
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

/*!
 * JSAnimationStep is manages the animations information.
 */
@interface JSAnimationStep : NSObject

@property (nonatomic)       NSTimeInterval         duration;
@property (nonatomic)       NSTimeInterval         delay;
@property (nonatomic)       UIViewAnimationOptions options;
@property (nonatomic, copy) void                   (^animations)(void);
@property (nonatomic, copy) void                   (^completion)(BOOL);

/*!
 * Create an empty animationStep.
 *
 * @return An empty animationStep.
 */
+ (instancetype)animationStep;

/*!
 * Create an animationStep using receiver's duration, animations block and completion block.
 *
 * @return An animationStep using receiver's duration, animations block and completion block.
 */
+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/*!
 * Create an animationStep using receiver's duration, delay, animations block and completion block.
 *
 * @return An animationStep using receiver's duration, delay, animations block and completion block.
 */
+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/*!
 * Create an animationStep using receiver's duration, delay, animation options, animation block and completion block.
 *
 * @return An animationStep using receiver's duration, delay, animation options, animation block and completion block.
 */
+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/*!
 * Initialize instance of animationStep using receiver's duration, animation block and completion block.
 *
 * @return An initialized animationStep object.
 */
- (id)initWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/*!
 * Initialize instance of animationStep using receiver's duration, delay, animation block and completion block.
 *
 * @return An initialized animationStep object.
 */
- (id)initWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/*!
 * Initialize instance of animationStep using receiver's duration, delay, animation options, animation block and completion block.
 *
 * @return An initialized animationStep object.
 */
- (id)initWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

@end
