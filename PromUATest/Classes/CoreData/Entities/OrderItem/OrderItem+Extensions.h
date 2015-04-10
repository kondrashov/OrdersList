//
//  OrderItem+Extensions.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderItem.h"
#import "NSManagedObject+Extensions.h"

@interface OrderItem (Extensions)

+ (OrderItem *)addItemWithId:(NSNumber *)itemId;
+ (OrderItem *)itemWithId:(NSNumber *)itemId;

@end
