//
//  NSDictionary+Cache.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "NSDictionary+Cache.h"
#import "THCache.h"

@implementation NSDictionary (Cache)

- (id)initDictionaryFromCacheWithKey:(NSString *)key
{
    self = [self initWithDictionary:[THCache restoreItemsFromCache:key]];
    return self;
}

- (BOOL)storeDictionaryToCacheWithKey:(NSString *)key
{
    return [THCache storeItemsToCache:self forKey:key];
}

- (BOOL)removeDictionaryFromCacheWithKey:(NSString *)key error:(NSError **)err
{
    return [THCache removeItemsFromCache:key error:err];
}

@end
