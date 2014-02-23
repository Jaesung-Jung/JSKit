//
//  UIView+Animation.m
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

#import "UIView+Animation.h"
#import "JSAnimationStep.h"

#pragma mark - Private Class
@interface UIAnimatior : NSObject

@property (nonatomic, strong) NSMutableArray *steps;

+ (instancetype)animatorWithSteps:(NSArray *)steps;
- (void)run;

@end

@implementation UIAnimatior

+ (instancetype)animatorWithSteps:(NSArray *)steps {
    UIAnimatior *instance = [[UIAnimatior alloc] init];
    instance.steps = [NSMutableArray arrayWithArray:steps];
    return instance;
}

- (void)run {
    if (![self.steps count]) {
        self.steps = nil;
        return;
    }

    JSAnimationStep *step = [self.steps firstObject];
    [UIView animateWithDuration:step.duration delay:step.delay options:step.options animations:step.animations completion:^(BOOL finished) {
        if (step.completion != nil)
            step.completion(finished);

        [self.steps removeObject:step];
        [self run];
    }];
}

@end

#pragma mark - Implementation
@implementation UIView (Animation)

+ (void)animateWithAnimationSteps:(NSArray *)steps {
    [[UIAnimatior animatorWithSteps:steps] run];
}

@end
