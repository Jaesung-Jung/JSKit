//
//  JSAnimationStep.m
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

#import "JSAnimationStep.h"

@implementation JSAnimationStep

+ (instancetype)animationStep
{
    return [[JSAnimationStep alloc] init];
}

+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    return [[JSAnimationStep alloc] initWithDuration:duration animations:animations completion:completion];
}

+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    return [[JSAnimationStep alloc] initWithDuration:duration delay:delay animations:animations completion:completion];
}

+ (instancetype)animationStepWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    return [[JSAnimationStep alloc] initWithDuration:duration delay:delay options:options animations:animations completion:completion];
}

- (id)initWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    return [self initWithDuration:duration delay:0.0 animations:animations completion:completion];
}

- (id)initWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    return [self initWithDuration:duration delay:delay options:0 animations:animations completion:completion];
}

- (id)initWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    if (self = [super init]) {
        self.duration = duration;
        self.delay = delay;
        self.options = options;
        self.animations = animations;
        self.completion = completion;
    }
    return self;
}

@end
