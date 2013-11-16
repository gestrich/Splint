//
//  IndexViewController.m
//  Splint
//
//  Created by William Gestrich on 7/22/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>

#import "VideoViewController.h"
#import "Video.h"
#import "RESTError.h"
#import "Urls.h"

#define INDEX_CELL_ID @"index_cell"

@interface IndexViewController ()


@property NSArray *videoItems;

@end

@implementation IndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //Fetch video list
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
     [delegate.engine fetchVideoItemsOnSucceeded:^(NSMutableArray *listOfModelBaseObjects) {
        
         NSLog(@"array = %@", listOfModelBaseObjects);
         self.videoItems = listOfModelBaseObjects;
         [self.tableView reloadData];
         
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
     
    
}


-(void)videoIndexRows:(id)responseData{
    
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"Dictionary = %@", dict);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Video *video = [self.videoItems objectAtIndex:indexPath.row];
    [self showVideo:video.urlString];
}

- (void)showVideo:(NSString *)urlString {

    NSString *url = [BASE_URL stringByAppendingString: urlString];

    VideoViewController *videoVc = [[VideoViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [self presentMoviePlayerViewControllerAnimated:videoVc];
}



#pragma mark - UITableViewDataSource Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.videoItems count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    Video *video = [self.videoItems objectAtIndex:indexPath.row];
    cell = [self.tableView dequeueReusableCellWithIdentifier:INDEX_CELL_ID];
    cell.textLabel.text = video.title;
    cell.detailTextLabel.text = video.videoLength;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.;
}


@end
