//
//  Order+Extensions.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "Order.h"
#import "NSManagedObject+Extensions.h"

typedef enum
{
    OrderStateNew,
    OrderStateAccepted,
    OrderStateDeclined,
    OrderStateDraft,
    OrderStateClosed
}OrderState;

@interface Order (Extensions)

+ (Order *)addOrderWithId:(NSNumber *)orderId;
+ (Order *)fetchOrderWithId:(NSNumber *)orderId;
+ (OrderState)orderStateForText:(NSString *)textState;
+ (void)asyncSearchOrdersWithText:(NSString *)searchString
                       completion:(void (^)(NSArray *objects, NSError *error))completion;

@end
