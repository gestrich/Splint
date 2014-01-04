//
//  ContentDetailViewController.m
//  Splint
//
//  Created by Bill Gestrich on 1/3/14.
//  Copyright (c) 2014 William Gestrich. All rights reserved.
//

#import "ContentDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>

@interface ContentDetailViewController ()

@property (strong, nonatomic) MPMoviePlayerController *player;
@end

@implementation ContentDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    [self.player prepareToPlay];
    [self.player.view setFrame:self.videoContainerView.bounds];
    [self.videoContainerView addSubview:self.player.view];
    [self.player play];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
