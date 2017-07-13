//
//  TNHomeService.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(id responseObj, NSError *error);

@interface TNHomeService : NSObject
+ (instancetype)sharedService;

- (void)requestMyChannelsWithParameters:(NSDictionary *)parameters callback:(Block)block;

- (void)requestAllChannelsWithParameters:(NSDictionary *)parameters callback:(Block)block;

- (void)requestNewsDatasWithParameters:(NSDictionary *)parameters callback:(Block)block;

@end
