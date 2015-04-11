//
//  OrderDetailCollectionCell.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface OrderDetailCollectionCell : UICollectionViewCell

- (void)configWithOrder:(Order *)order;

@end
