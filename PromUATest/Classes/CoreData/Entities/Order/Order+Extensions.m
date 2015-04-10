//
//  Order+Extensions.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "Order+Extensions.h"
#import "OrderItem+Extensions.h"

NSString *const kNew        = @"new";
NSString *const kAccepted   = @"accepted";
NSString *const kDeclined   = @"declined";
NSString *const kDraft      = @"draft";
NSString *const kClosed     = @"closed";

@implementation Order (Extensions)

+ (Order *)addOrderWithId:(NSNumber *)orderId
{
    Order *order = [self fetchOrderWithId:orderId];
    if(!order)
    {
        order = [self createNewObjectInContext:[self moc]];
        order.orderID = orderId;
        [self saveContext];
    }
    return order;
}

+ (Order *)fetchOrderWithId:(NSNumber *)orderId
{
    NSString *predicate = [NSString stringWithFormat:@"orderID = %@", orderId];
    NSArray *objects = [Order fetchObjectsByPredicate:predicate sortKey:nil ascending:NO context:[self moc]];
    return [objects firstObject];
}

+ (OrderState)orderStateForText:(NSString *)textState
{
    OrderState orderState;

    if([textState isEqualToString:kNew])
        orderState = OrderStateNew;
    else if([textState isEqualToString:kAccepted])
        orderState = OrderStateAccepted;
    else if ([textState isEqualToString:kDeclined])
        orderState = OrderStateDeclined;
    else if ([textState isEqualToString:kDraft])
        orderState = OrderStateDraft;
    else if ([textState isEqualToString:kClosed])
        orderState = OrderStateClosed;
    
    return orderState;
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];;
    [string appendString:[NSString stringWithFormat:@"orderId = %@\n", self.orderID]];
    [string appendString:@"Items:\n"];
    
    for(OrderItem *item in [self.items allObjects])
        [string appendString:[NSString stringWithFormat:@"%@\n", item]];
    
    return string;
}

+ (void)asyncSearchOrdersWithText:(NSString *)searchString
                       completion:(void (^)(NSArray *objects, NSError *error))completion
{
    NSString *predicateString = [NSString stringWithFormat:@"(orderNo LIKE[c] \"*%@*\") OR (name LIKE[c] \"*%@*\") OR (phone LIKE[c] \"*%@*\") OR (ANY items.name LIKE[c] \"*%@*\") OR (ANY items.sku LIKE[c] \"*%@*\")", searchString, searchString, searchString, searchString, searchString];

    [self asyncFetchObjectsByPredicate:predicateString sortKey:@"date" ascending:NO context:[self moc] completion:completion];
}


@end
