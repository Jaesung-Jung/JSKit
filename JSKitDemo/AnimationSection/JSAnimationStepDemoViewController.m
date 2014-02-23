//
//  JSAnimationStepDemoViewController.m
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

#import "JSAnimationStepDemoViewController.h"

@interface JSAnimationStepDemoViewController ()

@property (weak, nonatomic) IBOutlet UIView *animateView;
@property (weak, nonatomic) IBOutlet UIButton *startAnimationButton;

@property (nonatomic, strong) NSArray *animationSteps;

@end

@implementation JSAnimationStepDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animateView.backgroundColor = [UIColor ios7_orange];

    JSAnimationStep *step1 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.backgroundColor = [UIColor ios7_green];
    } completion:nil];
    JSAnimationStep *step2 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.alpha = 0.0f;
    } completion:nil];
    JSAnimationStep *step3 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.alpha = 1.0f;
    } completion:nil];
    JSAnimationStep *step4 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.backgroundColor = [UIColor ios7_orange];
    } completion:nil];
    JSAnimationStep *step5 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.frameY += 100;
    } completion:nil];
    JSAnimationStep *step6 = [JSAnimationStep animationStepWithDuration:1.0f animations:^{
        self.animateView.frameY -= 100;
    } completion:^(BOOL finished) {
        self.startAnimationButton.enabled = YES;
    }];

    self.animationSteps = @[step1, step2, step3, step4, step5, step6];
}

- (IBAction)startAnimation:(id)sender {
    self.startAnimationButton.enabled = NO;
    [UIView animateWithAnimationSteps:self.animationSteps];
}

@end
