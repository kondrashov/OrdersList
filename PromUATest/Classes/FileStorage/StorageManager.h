//
//  StoreManager.h
//  PromUATest
//
//  Created by Mobisoft on 06.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject

+ (NSURL *)xmlURL;
+ (NSString *)xmlPath;

+ (BOOL)checkFeedXml;
+ (BOOL)removeFeedXml;
+ (BOOL)saveFeedXml:(NSData *)xmlData;

+ (NSURL *)documentsDirectory;
+ (NSURL *)cachesDirectory;

+ (BOOL)writeDataToDocuments:(NSData *)data fileName:(NSString *)fileName;
+ (BOOL)writeDataToCaches:(NSData *)data fileName:(NSString *)fileName;
+ (BOOL)writeData:(NSData *)data path:(NSString *)path fileName:(NSString *)fileName;

@end
