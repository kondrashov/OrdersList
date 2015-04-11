//
//  OrderDetailTableHeader.m
//  PromUATest
//
//  Created by Mobisoft on 11.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderDetailTableHeader.h"
#import "Order.h"

#define HEADER_HEIGHT   184

@interface OrderDetailTableHeader ()

@property (weak, nonatomic) IBOutlet UILabel *lblOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblClientName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCompany;

@end

@implementation OrderDetailTableHeader

+ (CGFloat)headerHeight
{
    return HEADER_HEIGHT;
}

- (instancetype)initWithOrder:(Order *)order
{
    self = [super initWithNibNamed:nil];
    if(self)
    {
        self.lblOrderNo.text = [NSString stringWithFormat:@"Номер заказа: %@", order.orderNo.length ? order.orderNo : @"Неизвестно"];
        self.lblClientName.text = [NSString stringWithFormat:@"Заказчик: %@", order.name.length ? order.name : @"Неизвестно"];
        self.lblPhone.text = [NSString stringWithFormat:@"Телефон: %@", order.phone.length ? order.phone : @"Неизвестно"];
        self.lblEmail.text = [NSString stringWithFormat:@"Email: %@", order.email.length ? order.email : @"Неизвестно"];
        self.lblDeliveryAddress.text = [NSString stringWithFormat:@"Адрес доставки: %@", order.address.length ? order.address : @"Неизвестно"];
        self.lblCompany.text = [NSString stringWithFormat:@"Компания: %@", order.company.length ? order.company : @"Неизвестно"];
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"dd.MM.yy HH:MM"];
        NSString *stringDate = [dateFormatter stringFromDate:order.date];
        self.lblDate.text = [NSString stringWithFormat:@"Дата: %@", stringDate.length ? stringDate : @"Неизвестно"];
    }
    return self;
}

@end
