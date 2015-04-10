//
//  CoreDataManager.h
//  PromUATest
//
//  Created by Mobisoft on 06.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;

- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;

@end
