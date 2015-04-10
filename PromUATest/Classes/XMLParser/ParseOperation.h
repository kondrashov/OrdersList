//
//  ParseOperation.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"

@interface ParseOperation : NSOperation

- (id)initWithXmlURL:(NSURL *)url completion:(ParseCompletion)completion;

@end
