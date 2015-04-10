//
//  OrderItem.h
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order;

@interface OrderItem : NSManagedObject

@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * itemID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * sku;
@property (nonatomic, retain) Order *order;

@end
