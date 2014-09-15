//
//  NSDictionary+Cache.h
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Cache)

- (id)initDictionaryFromCacheWithKey:(NSString *)key;

- (BOOL)storeDictionaryToCacheWithKey:(NSString *)key;

- (BOOL)removeDictionaryFromCacheWithKey:(NSString *)key error:(NSError **)err;

@end
