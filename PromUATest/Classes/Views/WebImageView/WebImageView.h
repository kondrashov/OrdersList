//
//  WebImageView.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebImageView : UIImageView

- (void)loadImageWithStringURL:(NSString *)stringURL completion:(void(^)(BOOL isSuccess))completion;
- (void)cancelRequest;

@end
