//
//  OrderDetailViewController.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCollectionCell.h"
#import "Order.h"

@interface OrderDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    Order               *_order;
    NSArray             *_ordersArray;
    UICollectionView    *_ordersCollectionView;
    NSIndexPath         *_currentIndexPath;
}
@end

@implementation OrderDetailViewController

#pragma mark - Lifecycle

- (instancetype)initWithOrders:(NSArray *)orders currentOrder:(Order *)order
{
    self = [super init];
    if(self)
    {
        _order = order;
        _ordersArray = orders;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [NSString stringWithFormat:@"№%@", _order.orderID];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    _ordersCollectionView.origin = CGPointMake(0, 0);    
    [_ordersCollectionView scrollToItemAtIndexPath:_currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupCollectionView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Methods

- (void)setupView
{
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupCollectionView
{
    if(!_ordersCollectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
        [flowLayout setMinimumInteritemSpacing:0];
        [flowLayout setMinimumLineSpacing:0];
        
        _ordersCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _ordersCollectionView.backgroundColor = [UIColor whiteColor];
        _ordersCollectionView.delegate = self;
        _ordersCollectionView.dataSource = self;
        _ordersCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _ordersCollectionView.pagingEnabled = YES;
        
        [_ordersCollectionView registerClass:[OrderDetailCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([OrderDetailCollectionCell class])];
        
        [self.view addSubview:_ordersCollectionView];
        [_ordersCollectionView reloadData];
        
        NSInteger index = [_ordersArray indexOfObject:_order];
        _currentIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    }
}

#pragma mark - UICollectionView dataSource/delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ordersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OrderDetailCollectionCell class]) forIndexPath:indexPath];
    
    Order *order = _ordersArray[indexPath.row];
    if([order isKindOfClass:[Order class]])
        [cell configWithOrder:order];
    
    return cell;
}

@end
