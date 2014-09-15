//
//  THMoreFromDeveloperModel.h
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMoreFromDeleveloperDone    @"moreFromDeveloperLoaded"

@interface THMoreFromDeveloperModel : NSObject

@property (strong, nonatomic, readonly)NSArray *jsonResults;

- (void)loadDeveloperId:(NSString *)developerId;

- (void)loadAppId:(NSString *)appId;

- (void)loadAppIds:(NSArray *)appIds;

@end
