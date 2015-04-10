//
//  AppDelegate.h
//  PromUATest
//
//  Created by Mobisoft on 06.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ApplicationDelegate     [AppDelegate sharedDelegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;

@end

