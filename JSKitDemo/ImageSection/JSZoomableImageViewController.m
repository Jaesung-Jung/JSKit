//
//  JSZoomableImageViewController.m
//  JSKit
//
//  Created by 정재성 on 2014. 6. 23..
//  Copyright (c) 2014년 Jaesung Jung. All rights reserved.
//

#import "JSZoomableImageViewController.h"
#import "JSZoomableImageView.h"

@interface JSZoomableImageViewController ()

@property (weak, nonatomic) IBOutlet JSZoomableImageView *zoomableImageView;

@end

@implementation JSZoomableImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.zoomableImageView.image = [UIImage imageNamed:@"image2"];
}

@end
