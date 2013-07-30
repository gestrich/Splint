    //
//  IndexViewController.m
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "IndexViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>

#import "VideoViewController.h"
#import "APIWrapper.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:5000/"]];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * response, NSData * data, NSError *error){
        
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"stringData = %@", stringData);
    }];
     */
    APIWrapper *api = [APIWrapper get];
    [api sendRequest:@"GET" url:[NSURL URLWithString:@"http://www.google.com"] withParams:nil target:self callback:@selector(test:)];
                                
}

-(void)test:(id)responseData{
    NSLog(@"callback made");
    NSLog(@"Data = %@", responseData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showVideo:(UIButton *)sender {
    VideoViewController *videoVc = [[VideoViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"]];
    [self presentMoviePlayerViewControllerAnimated:videoVc];
}
@end
