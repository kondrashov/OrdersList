//
//  Helpers.m
//  PromUATest
//
//  Created by Mobisoft on 07.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+ (NSDate *)dateFromString:(NSString *)stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yy HH:mm"];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    return [dateFormatter dateFromString:stringDate];
}

@end
