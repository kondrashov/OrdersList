//
//  OrderItem+Extensions.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderItem+Extensions.h"

@implementation OrderItem (Extensions)

+ (OrderItem *)addItemWithId:(NSNumber *)itemId
{
    OrderItem *orderItem = [self itemWithId:itemId];
    if(!orderItem)
    {
        orderItem = [self createNewObjectInContext:[self moc]];
        orderItem.itemID = itemId;
        [self saveContext];
    }
    return orderItem;
}

+ (OrderItem *)itemWithId:(NSNumber *)itemId
{
    NSString *predicate = [NSString stringWithFormat:@"itemID = %@", itemId];
    NSArray *objects = [OrderItem fetchObjectsByPredicate:predicate sortKey:nil ascending:NO context:[self moc]];
    return [objects firstObject];
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"itemId = %@\n", self.itemID]];
    return string;
}

@end
