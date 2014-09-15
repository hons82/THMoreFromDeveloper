//
//  THCache.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "THCache.h"

@implementation THCache

+ (BOOL)storeItemsToCache:(id)cache forKey:(NSString *)key
{
    NSArray *cacheDirectories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = cacheDirectories[0];
    NSString* cachePath = [cacheDirectory stringByAppendingPathComponent: key];
    //[cache writeToFile: cachePath atomically: TRUE];
    return [NSKeyedArchiver archiveRootObject:cache toFile:cachePath];
}

+ (id)restoreItemsFromCache:(NSString *)key
{
    NSArray *cacheDirectories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = cacheDirectories[0];
    NSString* cachePath = [cacheDirectory stringByAppendingPathComponent: key];
    //NSDictionary* cache = [NSDictionary dictionaryWithContentsOfFile: cachePath];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
}

+ (BOOL)removeItemsFromCache:(NSString *)key error:(NSError **)err
{
    NSArray *cacheDirectories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = cacheDirectories[0];
    NSString* cachePath = [cacheDirectory stringByAppendingPathComponent: key];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:cachePath];
    if(exists == YES) return [fm removeItemAtPath:cachePath error:err];
    return exists;
}

@end
