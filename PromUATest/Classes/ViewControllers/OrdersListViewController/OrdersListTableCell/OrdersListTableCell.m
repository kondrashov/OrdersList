//
//  OrdersListTableCell.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrdersListTableCell.h"
#import "Order+Extensions.h"
#import "OrderItem+Extensions.h"

#define CELL_HEIGHT     88

@interface OrdersListTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTop;
@property (weak, nonatomic) IBOutlet UILabel *lblBottom;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@end

@implementation OrdersListTableCell

#pragma mark - Lifecycle

- (void)awakeFromNib
{

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.lblDateTime.text = @"";
    self.lblBottom.text = @"";
    self.lblTop.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

#pragma mark - Public methods

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (void)configureWithOrder:(Order *)order
{
    OrderItem *item = [order.items anyObject];
    
    self.lblTop.text = [NSString stringWithFormat:@"№%@ - %@", order.orderID, order.name];
    self.lblBottom.text = [NSString stringWithFormat:@"%@ грн - %@", order.price, item.name];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"dd MMMM HH:MM"];
    self.lblDateTime.text  = [dateFormatter stringFromDate:order.date];
}

@end
