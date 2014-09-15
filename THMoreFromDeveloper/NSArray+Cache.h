//
//  NSArray+Cache.h
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Cache)

- (id)initArrayFromCacheWithKey:(NSString *)key;

- (BOOL)storeArrayToCacheWithKey:(NSString *)key;

- (BOOL)removeArrayFromCacheWithKey:(NSString *)key error:(NSError **)err;

@end
