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

@implementation THMoreFromDeveloperCollectionViewController {
    NSArray *moreFromDeveloperIds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#ifdef APPIDS
    moreFromDeveloperIds = @[@"509943167",@"875251011",@"420636551",@"645859810",@"767319014"];
#else
    moreFromDeveloperIds = @[@"833472034"];
#endif
    self.model = [[THMoreFromDeveloperModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(appIdsLoaded:) name:kMoreFromDeleveloperDone object: nil];
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    // Tell the reachability that we want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = YES;
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
    
    // Manual Definition
    [self.collectionView registerClass:[THMoreFromDeveloperCell class] forCellWithReuseIdentifier:@"MoreFromDeveloperCellManual"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return [moreFromDeveloperIds count];
    return [self.model jsonResults] ? [self.model.jsonResults count] : 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row % 2 == 0 ? CGSizeMake(128.0, 148.0) : CGSizeMake(100.0, 120.0));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"CellType used: %@",(indexPath.row % 2 == 0 ? @"MoreFromDeveloperCellManual" : @"MoreFromDeveloperCell"));
    THMoreFromDeveloperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(indexPath.row % 2 == 0 ? @"MoreFromDeveloperCellManual" : @"MoreFromDeveloperCell") forIndexPath:indexPath];
    //[cell setupWithAppId:moreFromDeveloperIds[indexPath.row]];
    [cell setupWithLookUpDictionary:self.model.jsonResults[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell #%ld was selected", (long)indexPath.row);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.jsonResults[indexPath.row][@"trackViewUrl"]]];
}

#pragma mark - Callback

- (void)appIdsLoaded:(NSNotification* )notification {
    [self.collectionView reloadData];
}

- (void)reachabilityChanged:(NSNotification* )notification {
#ifdef APPIDS
    [self.model loadAppIds:moreFromDeveloperIds];
#else
    [self.model loadDeveloperId:moreFromDeveloperIds[0]];
#endif
}

@end