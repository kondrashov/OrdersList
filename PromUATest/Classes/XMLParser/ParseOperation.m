//
//  ParseOperation.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "ParseOperation.h"
#import "Order+Extensions.h"
#import "OrderItem+Extensions.h"
#import "NSManagedObject+Extensions.h"
#import "Helpers.h"

static NSString * const kOrders        = @"orders";
static NSString * const kOrder         = @"order";
static NSString * const kDate          = @"date";
static NSString * const kId            = @"id";
static NSString * const kState         = @"state";
static NSString * const kName          = @"name";
static NSString * const kPhone         = @"phone";
static NSString * const kEmail         = @"email";
static NSString * const kAddress       = @"address";
static NSString * const kIndex         = @"index";
static NSString * const kPaymentType   = @"paymentType";
static NSString * const kDeliveryType  = @"deliveryType";
static NSString * const kDeliveryCost  = @"deliverycost";
static NSString * const kPayerComment  = @"payercomment";
static NSString * const kSalesComment  = @"salescomment";
static NSString * const kItems         = @"items";
static NSString * const kItem          = @"item";
static NSString * const kQuantity      = @"quantity";
static NSString * const kCurrency      = @"currency";
static NSString * const kUrl           = @"url";
static NSString * const kPrice         = @"price";
static NSString * const kPriceUAH      = @"priceUAH";
static NSString * const kSku           = @"sku";
static NSString * const kImage         = @"image";
static NSString * const kCompany       = @"company";


@interface ParseOperation () <NSXMLParserDelegate>
{
    NSURL       *_xmlURL;
    Order       *_currentOrder;
    OrderItem   *_currentItem;
    NSString    *_currentElementName;
}

@property (copy, nonatomic) ParseCompletion parseCompletion;

@end

@implementation ParseOperation

- (id)initWithXmlURL:(NSURL *)url completion:(ParseCompletion)completion
{
    self = [super init];
    if(self)
    {
        _xmlURL = url;
        self.parseCompletion = completion;
    }
    return self;
}

- (void)main
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:_xmlURL];
    [parser setDelegate:self];
    BOOL isSuccess = [parser parse];
    self.parseCompletion(isSuccess);
}

#pragma mark - NSXMLParser delegate

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [NSManagedObject saveContext];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _currentElementName = elementName;
    
    if([_currentElementName isEqualToString:kOrder])
    {
        _currentItem = nil;
        
        NSNumber *orderId = @([[attributeDict objectForKey:kId] integerValue]);
        NSString *orderState = [attributeDict objectForKey:kState];

        _currentOrder = [Order addOrderWithId:orderId];
        _currentOrder.state = @([Order orderStateForText:orderState]);
        _currentOrder.orderNo = [NSString stringWithFormat:@"%@", _currentOrder.orderID];
    }
    else if([_currentElementName isEqualToString:kItem])
    {
        NSNumber *itemId = @([[attributeDict objectForKey:kId] integerValue]);
        _currentItem = [OrderItem addItemWithId:itemId];
        [_currentOrder addItemsObject:_currentItem];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    _currentElementName = nil;

    if([elementName isEqualToString:kItems])
    {
        _currentItem = nil;
    }
    else if ([elementName isEqualToString:kOrder])
    {
        _currentOrder = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSManagedObject *object = _currentItem ?: _currentOrder;
    
    if([_currentElementName isEqualToString:kName])
    {
        [object setValue:string forKey:kName];
    }
    else if ([_currentElementName isEqualToString:kCompany])
    {
        [object setValue:string forKey:kCompany];
    }
    else if ([_currentElementName isEqualToString:kPhone])
    {
        [object setValue:string forKey:kPhone];
    }
    else if ([_currentElementName isEqualToString:kEmail])
    {
        [object setValue:string forKey:kEmail];
    }
    else if ([_currentElementName isEqualToString:kAddress])
    {
        [object setValue:string forKey:kAddress];
    }
    else if ([_currentElementName isEqualToString:kIndex])
    {
        [object setValue:string forKey:kIndex];
    }
    else if ([_currentElementName isEqualToString:kPaymentType])
    {
        [object setValue:string forKey:kPaymentType];
    }
    else if ([_currentElementName isEqualToString:kDeliveryType])
    {
        [object setValue:string forKey:kDeliveryType];
    }
    else if ([_currentElementName isEqualToString:kDeliveryCost])
    {
        [object setValue:string forKey:kDeliveryCost];
    }
    else if ([_currentElementName isEqualToString:kPayerComment])
    {
        [object setValue:string forKey:kPayerComment];
    }
    else if ([_currentElementName isEqualToString:kSalesComment])
    {
        [object setValue:string forKey:kSalesComment];
    }
    else if ([_currentElementName isEqualToString:kPriceUAH] || [_currentElementName isEqualToString:kPrice])
    {
        [object setValue:@([string floatValue]) forKey:kPrice];
    }    
    else if ([_currentElementName isEqualToString:kDate])
    {
        [object setValue:[Helpers dateFromString:string] forKey:kDate];
    }
    else if ([_currentElementName isEqualToString:kQuantity])
    {
        [object setValue:@([string integerValue]) forKey:kQuantity];
    }
    else if ([_currentElementName isEqualToString:kCurrency])
    {
        [object setValue:string forKey:kCurrency];
    }
    else if ([_currentElementName isEqualToString:kImage])
    {
        [object setValue:string forKey:kImage];
    }
    else if ([_currentElementName isEqualToString:kUrl])
    {
        [object setValue:string forKey:kUrl];
    }
    else if ([_currentElementName isEqualToString:kSku])
    {
        [object setValue:string forKey:kSku];
    }
}

@end
