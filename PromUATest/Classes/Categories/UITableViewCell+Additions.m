//
//  UITableViewCell+Additions.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "UITableViewCell+Additions.h"

@implementation UITableViewCell (Additions)

+ (instancetype)cellForTableView:(UITableView *)tableView withCellId:(NSString *)cellId owner:(id)owner
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:owner options:nil];
        if (nibObjects.count > 0)
        {
            cell = nibObjects[0];
        }
    }
    if (![cell isKindOfClass:[self class]])
        cell = nil;

    return cell;
}

@end
