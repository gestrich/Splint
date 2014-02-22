//
//  ContentDetailViewController.h
//  Splint
//
//  Created by Bill Gestrich on 1/3/14.
//  Copyright (c) 2014 William Gestrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface ContentDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *videoContainerView;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) Video *video;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end
