//
//  XMLParser.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "XMLParser.h"
#import "ParseOperation.h"

@interface XMLParser ()
{
    NSOperationQueue    *_parseQueue;
    ParseOperation      *_parseOperation;
}

@end

@implementation XMLParser

+ (void)parseXmlWithURL:(NSURL *)xmlURL completion:(ParseCompletion)completion
{
    [[XMLParser new] parseXmlWithURL:xmlURL completion:completion];
}

- (void)parseXmlWithURL:(NSURL *)xmlURL completion:(ParseCompletion)completion;
{
    self.parseCompletion = completion;
    
    _parseOperation = [[ParseOperation alloc] initWithXmlURL:xmlURL completion:completion];
    _parseQueue = [NSOperationQueue new];
    [_parseQueue addOperation:_parseOperation];
}



@end
