//
//  NetworkManager.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRequest.h"

@interface NetworkManager : NSObject

+ (void)loadXmlFeedWithCompletion:(CompletionBlock)completion;

@end
