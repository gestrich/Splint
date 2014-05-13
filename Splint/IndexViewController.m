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

#import "IndexCell.h"
#import "Video.h"
#import "RESTError.h"
#import "ContentDetailViewController.h"
#import "HTTPRequestManger.h"

#define INDEX_CELL_ID @"index_cell"
#define INDEX_CELL_HEIGHT 160.

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
    [delegate.afManager fetchVideoItemsOnSucceeded:^(NSMutableArray *listOfModelBaseObjects) {
        self.videoItems = listOfModelBaseObjects;
        [self.collectionView reloadData];
    } onError:^(NSError *engineError) {
        //Show error
    }];
    
    
    /*
     [delegate.engine fetchVideoItemsOnSucceeded:^(NSMutableArray *listOfModelBaseObjects) {
        
         self.videoItems = listOfModelBaseObjects;
         [self.collectionView reloadData];
         
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
    */
    
    //Fetch video list
    

     
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    Video *video = [self.videoItems objectAtIndex:indexPath.row];
    [self showVideo:video];
}

- (void)showVideo:(Video *)video{

    NSString *url = [BASE_URL stringByAppendingPathComponent:video.urlString];
    ContentDetailViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"content"];
    contentVC.videoURL = [NSURL URLWithString:url];
    contentVC.video = video;

    
    [self.navigationController pushViewController:contentVC animated:YES];
    
}



#pragma mark - UITableViewDataSource Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.videoItems count];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IndexCell *cell;
    
    Video *video = [self.videoItems objectAtIndex:indexPath.row];
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:INDEX_CELL_ID forIndexPath:indexPath];
    cell.titleView.text = video.title;
    cell.titleView.numberOfLines = 0;
    cell.imageView.image = nil;

    if(video.imageUrl){
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [delegate.afManager fetchImageItem:video.imageUrl OnSucceeded:^(NSMutableArray *listOfModelBaseObjects) {
            dispatch_async(dispatch_get_main_queue(), ^{
                IndexCell *updateCell = (IndexCell *)[collectionView cellForItemAtIndexPath:indexPath];
                if(listOfModelBaseObjects && [listOfModelBaseObjects count] > 0){
                    [updateCell.imageView setImage:[listOfModelBaseObjects lastObject]];
                }
            });

        } onError:nil];
        
    }

    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.width, INDEX_CELL_HEIGHT);

}

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(BOOL) shouldAutorotate{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionViewLayout invalidateLayout];
}

@end
