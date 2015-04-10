//
//  StoreManager.m
//  PromUATest
//
//  Created by Mobisoft on 06.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "StorageManager.h"

static NSString * const kXmlFileName = @"feed.xml";

@implementation StorageManager

#pragma mark - Special methods

+ (NSURL *)xmlURL
{
    return [NSURL fileURLWithPath:[self xmlPath]];
}

+ (NSString *)xmlPath
{
    return [NSString stringWithFormat:@"%@/%@", [self cachesDirectory].path, kXmlFileName];
}

+ (BOOL)checkFeedXml
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self xmlPath]];
}

+ (BOOL)saveFeedXml:(NSData *)xmlData
{
    return [self writeDataToCaches:xmlData fileName:kXmlFileName];
}

+ (BOOL)removeFeedXml
{
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtURL:[self xmlURL] error:&error];
}

#pragma mark - Common methods

+ (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)cachesDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (BOOL)writeDataToDocuments:(NSData *)data fileName:(NSString *)fileName
{
    return [self writeData:data path:[self documentsDirectory].path fileName:fileName];
}

+ (BOOL)writeDataToCaches:(NSData *)data fileName:(NSString *)fileName
{
    return [self writeData:data path:[self cachesDirectory].path fileName:fileName];
}

+ (BOOL)writeData:(NSData *)data path:(NSString *)path fileName:(NSString *)fileName
{
    NSError *error;
    NSString *storePath = [NSString stringWithFormat:@"%@/%@", path, fileName];
    BOOL isSuccess = [data writeToFile:storePath options:NSDataWritingAtomic error:&error];
    return isSuccess;
}

@end
