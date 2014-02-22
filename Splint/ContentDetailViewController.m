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
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ContentDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    [self.player prepareToPlay];
    [self.videoContainerView addSubview:self.player.view];
    [self.player.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.videoContainerView setTranslatesAutoresizingMaskIntoConstraints: NO];
    UIView *playerView = self.player.view;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[playerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(playerView)];
    [self.videoContainerView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[playerView]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(playerView)];
    [self.videoContainerView addConstraints:constraints];
    self.player.shouldAutoplay = NO;
    
    self.titleLabel.text = self.video.title;
    self.textView.text = self.video.desc;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
