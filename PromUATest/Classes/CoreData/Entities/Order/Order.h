//
//  Order.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderItem;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * deliverycost;
@property (nonatomic, retain) NSString * deliveryType;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * index;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderID;
@property (nonatomic, retain) NSString * payercomment;
@property (nonatomic, retain) NSString * paymentType;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * orderNo;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * salescomment;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSSet *items;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addItemsObject:(OrderItem *)value;
- (void)removeItemsObject:(OrderItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
