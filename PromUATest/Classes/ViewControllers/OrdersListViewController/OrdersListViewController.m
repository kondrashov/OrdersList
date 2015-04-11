//
//  OrdersListViewController.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrderDetailViewController.h"
#import "UITableViewCell+Additions.h"
#import "UIView+Additions.h"
#import "OrdersListTableCell.h"
#import "NetworkManager.h"
#import "StorageManager.h"
#import "SearchView.h"
#import "XMLParser.h"
#import "Order+Extensions.h"

@interface OrdersListViewController () <UITableViewDataSource, UITableViewDelegate, SearchViewDelegate>
{
    UITableView                 *_ordersTableView;
    SearchView                  *_searchView;
    NSMutableArray              *_ordersArray;
    UIActivityIndicatorView     *_activityIndicator;
    BOOL                        _isLayoutDone;
}
@end

@implementation OrdersListViewController

#pragma mark - Lifecycle

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Заказы";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createObservers];
    [self setupView];
    [self setupSearchView];
    [self setupTable];
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (void)createObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)loadData
{
    _ordersTableView.hidden = YES;
    _activityIndicator.hidden = NO;
    [_activityIndicator startAnimating];

    [self loadDataWithCompletion:^(BOOL isSuccess)
    {
        [self fetchDataWithCompletion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _activityIndicator.hidden = YES;
                [_activityIndicator stopAnimating];
                [_ordersTableView reloadData];
                _ordersTableView.hidden = NO;
            });        
        }];
    }];
}

- (void)reloadDataWithCompletion:(void (^)())completion
{
    [self loadDataWithCompletion:^(BOOL isSuccess)
     {
         [self fetchDataWithCompletion:^{
             [_ordersTableView reloadData];

             if(completion != NULL)
                 completion();
         }];
     }];
}

- (void)fetchDataWithCompletion:(void (^)())completion
{
    if(!_ordersArray)
        _ordersArray = [NSMutableArray array];
    
    [_ordersArray removeAllObjects];
    [Order asyncFetchObjectsByPredicate:nil sortKey:@"date" ascending:NO context:[Order moc] completion:^(NSArray *objects, NSError *error)
    {
        [_ordersArray addObjectsFromArray:objects];
        
        if(completion != NULL)
            completion();
    }];
}

- (void)layoutViews
{
    if(!_isLayoutDone)
    {
        _searchView.origin = CGPointMake(0, 0);
        _ordersTableView.frame = CGRectMake(0, _searchView.bottomY, self.view.width, self.view.height - _searchView.bottomY);
        _activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f);
        _isLayoutDone = YES;
    }
}

- (void)setupView
{
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if(!_activityIndicator)
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:_activityIndicator];
}

- (void)setupSearchView
{
    if(!_searchView)
    {
        _searchView = [[SearchView alloc] initWithDelegate:self];
        _searchView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_searchView];
    }
}

- (void)setupTable
{
    if(!_ordersTableView)
    {
        _ordersTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _ordersTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _ordersTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _ordersTableView.delegate = self;
        _ordersTableView.dataSource = self;
        
        UIRefreshControl *refreshControl = [UIRefreshControl new];
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        [_ordersTableView addSubview:refreshControl];
        
        [self.view addSubview:_ordersTableView];
    }
}

- (void)loadDataWithCompletion:(void (^)(BOOL isSuccess))completion
{
    [NetworkManager loadXmlFeedWithCompletion:^(NSData *data, BOOL fromCache, NSError *error)
     {
         if(!error && data.length > 0)
         {
             if([StorageManager saveFeedXml:data])
             {
                 [XMLParser parseXmlWithURL:[StorageManager xmlURL] completion:^(BOOL success)
                  {
                      [StorageManager removeFeedXml];
                      completion(YES);
                  }];
             }
             else
                 completion(NO);
         }
         else
             completion(NO);
     }];
}

#pragma mark - UITableView dataSource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ordersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdersListTableCell *cell = [OrdersListTableCell cellForTableView:tableView withCellId:NSStringFromClass([OrdersListTableCell class]) owner:self];
    
    Order *order = _ordersArray[indexPath.row];
    
    if([order isKindOfClass:[Order class]])
        [cell configureWithOrder:order];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrdersListTableCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didEndEntering];
    Order *order = _ordersArray[indexPath.row];
    if(order && [order isKindOfClass:[Order class]])
    {
        OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithOrders:_ordersArray currentOrder:order];
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
}

#pragma mark - Actions

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self reloadDataWithCompletion:^{
        [refreshControl endRefreshing];
    }];
}

#pragma mark - SearchView delegate

- (void)didEnterText:(NSString *)text
{
    if(text.length > 0)
    {
        [Order asyncSearchOrdersWithText:text completion:^(NSArray *objects, NSError *error) {
            [_ordersArray removeAllObjects];
            [_ordersArray addObjectsFromArray:objects];
            [_ordersTableView reloadData];
        }];
    }
    else
    {
        [self fetchDataWithCompletion:^{
            [_ordersTableView reloadData];
        }];
    }
}

- (void)didBeginEntering
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didEndEntering
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didPressCancel
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Notifications handlers

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    if(keyboardSize.height * keyboardSize.width > 0)
        _ordersTableView.height = self.view.height - _searchView.bottomY - keyboardSize.height;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    _ordersTableView.height = self.view.height - _searchView.bottomY;
}

@end
