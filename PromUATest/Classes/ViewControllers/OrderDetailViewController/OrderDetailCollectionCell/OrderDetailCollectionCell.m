//
//  OrderDetailCollectionCell.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderDetailCollectionCell.h"
#import "OrderDetailTableCell.h"
#import "OrderDetailTableHeader.h"
#import "Order.h"
#import "OrderItem.h"

@interface OrderDetailCollectionCell () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView     *_orderTableView;
    Order           *_order;
    NSArray         *_itemsArray;
}
@end

@implementation OrderDetailCollectionCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupCell];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    _itemsArray = nil;
    _order = nil;
    [_orderTableView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _orderTableView.origin = CGPointMake(0, 20);
}

#pragma mark - Private methods

- (void)setupCell
{
    if(!_orderTableView)
    {
        _orderTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _orderTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_orderTableView];
        _orderTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
    }
}

#pragma mark - Public methods

- (void)configWithOrder:(Order *)order
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    
    _order = order;
    _itemsArray = [[_order.items allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
    [_orderTableView reloadData];
}


#pragma mark - UITableView dataSource/delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrderDetailTableCell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[OrderDetailTableHeader alloc] initWithOrder:_order];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [OrderDetailTableHeader headerHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailTableCell *cell = [OrderDetailTableCell cellForTableView:tableView withCellId:NSStringFromClass([OrderDetailTableCell class]) owner:self];
    
    OrderItem *item = _itemsArray[indexPath.row];
    [cell configWithItem:item];
    return cell;
}



@end
