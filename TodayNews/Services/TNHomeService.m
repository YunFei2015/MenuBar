//
//  TNHomeService.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNHomeService.h"
#import "MTAPIClient.h"

@implementation TNHomeService
+ (instancetype)sharedService
{
    static id sharedService = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedService = [[self alloc] init];
    });
    return sharedService;
}


- (void)requestMyChannelsWithParameters:(NSDictionary *)parameters callback:(Block)block{
    NSString *path = [kBaseUrl stringByAppendingString:kMyChannelsUrl];
    [self requestDatasWithPath:path parameters:parameters callback:block];
}

- (void)requestAllChannelsWithParameters:(NSDictionary *)parameters callback:(Block)block{
    NSString *path = [kBaseUrl stringByAppendingString:kAllChannelsUrl];
    [self requestDatasWithPath:path parameters:parameters callback:block];
}

- (void)requestNewsDatasWithParameters:(NSDictionary *)parameters callback:(Block)block{
    NSString *path = [kBaseUrl stringByAppendingString:kNewsDataUrl];
    [self requestDatasWithPath:path parameters:parameters callback:block];
}


- (void)requestDatasWithPath:(NSString *)path parameters:(NSDictionary *)parameters callback:(Block)block{
    [[MTAPIClient sharedAPIClient] requestJSONDataWithMethod:GET Path:path parameters:parameters callback:^(id responseObj, NSError *error) {
        if (error) {
            MTLog(@"%@", error);
            block(nil, error);
            return;
        }
        
        block(responseObj, nil);
    }];
}
@end
