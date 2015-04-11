//
//  OrderDetailTableCell.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderItem;

@interface OrderDetailTableCell : UITableViewCell

- (void)configWithItem:(OrderItem *)item;
+ (CGFloat)cellHeight;

@end
