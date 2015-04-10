//
//  SearchView.m
//  PromUATest
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithDelegate:(id<SearchViewDelegate>)delegate
{
    self = [super initWithNibNamed:nil];
    if(self)
    {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender
{
    [self endEditing:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didPressCancel)])
        [self.delegate didPressCancel];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didBeginEntering)])
        [self.delegate didBeginEntering];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didEndEntering)])
        [self.delegate didEndEntering];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didEnterText:)])
        [self.delegate didEnterText:@""];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didEnterText:)])
        [self.delegate didEnterText:searchStr];

    return YES;
}
@end
