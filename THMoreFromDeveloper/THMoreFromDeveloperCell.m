//
//  THMoreFromDeveloperCell.m
//  THMoreFromDeveloperExample
//
//  Created by Hannes Tribus on 15/09/14.
//  Copyright (c) 2014 3Bus. All rights reserved.
//

#import "THMoreFromDeveloperCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation THMoreFromDeveloperCell

- (void)setupWithAppId:(NSString *)appId
{
    [self.appNameLabel setText:NSLocalizedString(@"Loading...", @"")];
    
    NSLog(@"URL: %@",[NSString stringWithFormat:@"http://itunes.apple.com/lookup?country=%@&lang=%@&id=%@",[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode],[[NSLocale preferredLanguages] objectAtIndex:0],appId]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?country=%@&lang=%@&id=%@",[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode],[[NSLocale preferredLanguages] objectAtIndex:0],appId]]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:nil];
                               NSLog(@"Async JSON: %@", json);
                               if (!connectionError && json && json[@"resultCount"]>0) {
                                   [self.appNameIcon sd_setImageWithURL:[NSURL URLWithString:json[@"results"][0][@"artworkUrl100"]] placeholderImage:[UIImage imageNamed:@"emptyIcon.png"]];
                                   [self.appNameLabel setText:json[@"results"][0][@"trackName"]];
                               } else {
                                   [self.appNameIcon setImage:[UIImage imageNamed:@"emptyIcon.png"]];
                                   [self.appNameLabel setText:NSLocalizedString(@"Unable to load", @"")];
                               }
                           }];
}

- (void)setupWithLookUpDictionary:(NSDictionary *)appData
{
    [self setupWithLookUpDictionary:appData andPlaceHolderImage:@"emptyIcon.png"];
}

- (void)setupWithLookUpDictionary:(NSDictionary *)appData andPlaceHolderImage:(NSString *)placeholder
{
    [self.appNameIcon sd_setImageWithURL:[NSURL URLWithString:appData[@"artworkUrl100"]] placeholderImage:[UIImage imageNamed:placeholder]];
    [self.appNameLabel setText:appData[@"trackName"]];
}

- (void)drawRect:(CGRect)rect
{
    // TODO http://stackoverflow.com/questions/10563986/uiimage-with-rounded-corners
    [self.appNameIcon.layer setMasksToBounds:YES];
    [self.appNameIcon.layer setCornerRadius:30.0];
}


@end
