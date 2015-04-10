//
//  OrdersListTableCell.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface OrdersListTableCell : UITableViewCell

- (void)configureWithOrder:(Order *)order;
+ (CGFloat)cellHeight;

@end
