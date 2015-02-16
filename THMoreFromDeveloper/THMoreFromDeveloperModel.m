//
//  THMoreFromDeveloperModel.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "THMoreFromDeveloperModel.h"

#import <Reachability/Reachability.h>

#import "NSArray+Cache.h"

typedef enum : NSUInteger {
    ITunesRequestTypeUnknown,
    ITunesRequestTypeSoftware,
} ITunesRequestType;

@interface THMoreFromDeveloperModel ()
@property (strong, nonatomic)NSMutableArray *openRequestIds;
@end

@implementation THMoreFromDeveloperModel {
    Reachability* reach;
    NSArray *itemsToReturn;
    BOOL isReachable;
}

@synthesize jsonResults = _jsonResults;
@synthesize openRequestIds = _openRequestIds;

- (NSMutableArray *)openRequestIds {
    if (!_openRequestIds) _openRequestIds = [[NSMutableArray alloc] init];
    return _openRequestIds;
}

- (id)init {
    self = [super init];
    if (self) {
        reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
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
    return self;
}

- (void)dealloc {
    [reach stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setOpenRequestIds:nil];
    itemsToReturn = nil;
    _jsonResults = nil;
}

- (BOOL)loadAppId:(NSString *)appId iTunesRequestType:(ITunesRequestType)type {
    // If not reachable try to take them from cache
    if (!isReachable) {
        [self loadAppIdsFromCache:itemsToReturn ? itemsToReturn : @[appId]];
        return NO;
    }
    [self.openRequestIds addObject:appId];
    NSURLRequest *request;
    switch (type) {
        case ITunesRequestTypeSoftware:
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?country=%@&lang=%@&id=%@&entity=software",[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode],[[NSLocale preferredLanguages] objectAtIndex:0],appId]]];
            break;
        default:
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?country=%@&lang=%@&id=%@",[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode],[[NSLocale preferredLanguages] objectAtIndex:0],appId]]];
            break;
    }
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!connectionError) {
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:nil];
#ifdef DEBUG
                                   NSLog(@"Async JSON: %@", json);
#endif
                                   if (!connectionError && json && json[@"resultCount"]>0) {
                                       NSArray *tmp = nil;
                                       switch (type) {
                                           case ITunesRequestTypeSoftware:
                                               if ([json[@"results"] count] > 1) {
                                                   tmp = [json[@"results"] subarrayWithRange:NSMakeRange(1, [json[@"results"] count]-1)];
                                               }
                                               break;
                                           default:
                                               tmp = json[@"results"];
                                               break;
                                       }
                                       if (tmp) {
                                           [tmp storeArrayToCacheWithKey:appId];
                                       }
                                       
                                       [self.openRequestIds removeObject:appId];
                                       if ([self.openRequestIds count]==0) {
                                           [self loadAppIdsFromCache:itemsToReturn ? itemsToReturn : @[appId]];
                                       }
                                       
                                   }
                               }
                           }];
    return YES;
}

- (void)loadDeveloperId:(NSString *)developerId {
    [self loadAppId:developerId iTunesRequestType:ITunesRequestTypeSoftware];
}

- (void)loadAppId:(NSString *)appId {
    [self loadAppId:appId iTunesRequestType:ITunesRequestTypeUnknown];
}

- (void)loadAppIds:(NSArray *)appIds {
    itemsToReturn = [appIds copy];
    for (NSString *appId in appIds) {
        if (![self loadAppId:appId iTunesRequestType:ITunesRequestTypeUnknown])
            break;
    }
}

- (void)loadAppIdsFromCache:(NSArray *)appIds {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[appIds count]];
    for (NSString *appId in appIds) {
        NSArray *json = [[NSArray alloc] initArrayFromCacheWithKey:appId];
        if (json) {
            [result addObjectsFromArray:json];
        }
    }
    _jsonResults = [result copy];
    [self sendDoneNotification];
}

- (void)sendDoneNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kMoreFromDeleveloperDone object:self userInfo:(_jsonResults ? @{@"results" : _jsonResults} : nil)];
}

- (void)reachabilityChanged:(NSNotification* )notification {
    Reachability* curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    isReachable = [curReach isReachable];
}

@end
