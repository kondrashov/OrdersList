//
//  XMLParser.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ParseCompletion)(BOOL success);

@interface XMLParser : NSObject

@property (copy, nonatomic) ParseCompletion parseCompletion;

+ (void)parseXmlWithURL:(NSURL *)xmlURL completion:(ParseCompletion)completion;

@end
