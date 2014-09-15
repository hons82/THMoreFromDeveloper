//
//  THCache.h
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THCache : NSObject

+ (BOOL)storeItemsToCache:(id)cache forKey:(NSString *)key;
+ (id)restoreItemsFromCache:(NSString *)key;
+ (BOOL)removeItemsFromCache:(NSString *)key error:(NSError **)err;

@end
