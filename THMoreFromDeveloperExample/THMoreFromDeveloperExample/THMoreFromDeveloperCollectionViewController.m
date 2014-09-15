//
//  THMoreFromDeveloperCollectionViewController.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "THMoreFromDeveloperCollectionViewController.h"

#import <Reachability/Reachability.h>

#import "THMoreFromDeveloperCell.h"
#import "THMoreFromDeveloperModel.h"

@interface THMoreFromDeveloperCollectionViewController ()
@property (nonatomic,strong)THMoreFromDeveloperModel *model;
@end

@implementation THMoreFromDeveloperCollectionViewController
{
    NSArray *moreFromDeveloperIds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //moreFromDeveloperIds = @[@"509943167",@"875251011",@"420636551",@"645859810",@"767319014"];
    moreFromDeveloperIds = @[@"298910979"];
    self.model = [[THMoreFromDeveloperModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(appIdsLoaded:) name:kMoreFromDeleveloperDone object: nil];
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Tell the reachability that we want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = YES;
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return [moreFromDeveloperIds count];
    return [self.model jsonResults] ? [self.model.jsonResults count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    THMoreFromDeveloperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoreFromDeveloperCell" forIndexPath:indexPath];
    //[cell setupWithAppId:moreFromDeveloperIds[indexPath.row]];
    [cell setupWithLookUpDictionary:self.model.jsonResults[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell #%ld was selected", (long)indexPath.row);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.jsonResults[indexPath.row][@"trackViewUrl"]]];
}

#pragma mark - Callback

- (void)appIdsLoaded:(NSNotification* )notification
{
    [self.collectionView reloadData];
}

- (void)reachabilityChanged:(NSNotification* )notification
{
    [self.model loadDeveloperId:moreFromDeveloperIds[0]];
}

@end