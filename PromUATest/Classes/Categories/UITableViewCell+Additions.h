//
//  UITableViewCell+Additions.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Additions)

+ (instancetype)cellForTableView:(UITableView *)tableView withCellId:(NSString *)cellId owner:(id)owner;

@end
