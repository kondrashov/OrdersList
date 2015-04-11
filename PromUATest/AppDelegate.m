//
//  AppDelegate.m
//  PromUATest
//
//  Created by Mobisoft on 06.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "AppDelegate.h"
#import "OrdersListViewController.h"
#import "CoreDataManager.h"
#import "StorageManager.h"
#import "Helpers.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initUI];
    
    NSLog(@"%@", [StorageManager documentsDirectory]);
    
    return YES;
}

#pragma mark - Methods

+ (AppDelegate *)sharedDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

- (void)initUI
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[OrdersListViewController new]];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

#pragma mark - Application events

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[CoreDataManager sharedInstance] saveContext];
}

@end
