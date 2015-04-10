//
//  NetworkManager.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "NetworkManager.h"
#import "StorageManager.h"

NSString * const xmlURL = @"https://my.prom.ua/cabinet/export_orders/xml/306906?hash_tag=e1177d00a4ec9b6388c57ce8e85df009";

@implementation NetworkManager

+ (void)loadXmlFeedWithCompletion:(CompletionBlock)completion
{
    [DataRequest loadDataWithStringURL:xmlURL progress:NULL completion:completion cacheEnabled:NO];
}

@end
