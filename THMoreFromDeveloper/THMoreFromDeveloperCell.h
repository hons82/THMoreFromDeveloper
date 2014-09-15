//
//  THMoreFromDeveloperCell.h
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THMoreFromDeveloperCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appNameIcon;

- (void)setupWithAppId:(NSString *)appId;
- (void)setupWithLookUpDictionary:(NSDictionary *)appData;

@end
