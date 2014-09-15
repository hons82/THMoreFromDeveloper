//
//  NSArray+Cache.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "NSArray+Cache.h"
#import "THCache.h"

@implementation NSArray (Cache)

- (id)initArrayFromCacheWithKey:(NSString *)key
{
    self = [self initWithArray:[THCache restoreItemsFromCache:key]];
    return self;
}

- (BOOL)storeArrayToCacheWithKey:(NSString *)key
{
    return [THCache storeItemsToCache:self forKey:key];
}

- (BOOL)removeArrayFromCacheWithKey:(NSString *)key error:(NSError **)err
{
    return [THCache removeItemsFromCache:key error:err];
}

@end
