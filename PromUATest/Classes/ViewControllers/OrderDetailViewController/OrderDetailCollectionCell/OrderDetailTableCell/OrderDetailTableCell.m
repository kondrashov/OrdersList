//
//  OrderDetailTableCell.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderDetailTableCell.h"
#import "OrderItem+Extensions.h"
#import "DataRequest.h"
#import "WebImageView.h"

#define CELL_HEIGHT         98

@interface OrderDetailTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTop;
@property (weak, nonatomic) IBOutlet UILabel *lblMiddle;
@property (weak, nonatomic) IBOutlet WebImageView *photoView;

@end

@implementation OrderDetailTableCell

#pragma mark - Lifecycle

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.photoView cancelRequest];
    self.photoView.image = nil;
    self.lblTop.text = @"";
    self.lblMiddle.text = @"";
}

#pragma mark - Public methods

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (void)configWithItem:(OrderItem *)item
{
    self.lblTop.text = item.name;
    self.lblMiddle.text = [NSString stringWithFormat:@"%@ грн", item.price];
    [self.photoView loadImageWithStringURL:item.image completion:NULL];
}

@end
