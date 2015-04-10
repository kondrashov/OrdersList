//
//  SearchView.h
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate <NSObject>

- (void)didPressCancel;
- (void)didBeginEntering;
- (void)didEndEntering;
- (void)didEnterText:(NSString *)text;

@end

@interface SearchView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) id<SearchViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<SearchViewDelegate>)delegate;

@end
