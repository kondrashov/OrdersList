//
//  OrderDetailTableHeader.h
//  PromUATest
//
//  Created by Mobisoft on 11.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface OrderDetailTableHeader : UIView

+ (CGFloat)headerHeight;
- (instancetype)initWithOrder:(Order *)order;

@end
