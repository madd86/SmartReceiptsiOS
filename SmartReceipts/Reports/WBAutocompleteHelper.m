//
//  WBAutocompleteHelper.m
//  SmartReceipts
//
//  Created on 08/04/14.
//  Copyright (c) 2014 Will Baumann. All rights reserved.
//

#import "WBAutocompleteHelper.h"
#import "WBPreferences.h"
#import "Database+Hints.h"
#import "SuggestionView.h"
#import "NSString+Extensions.h"

@interface WBAutocompleteHelper () <SuggestionViewDelegate>

@property (weak, nonatomic) UITextField *field;
@property (strong, nonatomic) SuggestionView *suggestionView; // appears above keyboard
@property (assign, nonatomic) BOOL forReceipts;

@end

@implementation WBAutocompleteHelper

#pragma mark - Initialization

- (id)initWithAutocompleteField:(UITextField *)field useReceiptsHints:(BOOL)forReceipts
{
    self = [super init];
    if (self) {
        _field = field;
        _forReceipts = forReceipts;
        self.field.inputAccessoryView = nil;
        self.field.autocorrectionType = UITextAutocorrectionTypeYes;
        [self.field reloadInputViews];
    }
    return self;
}

- (SuggestionView *)suggestionView {
    if (_suggestionView) {
        return _suggestionView;
    } else {
        _suggestionView = [SuggestionView new];
        _suggestionView.maxSuggestionCount = 3;
        _suggestionView.delegate = self;
        return _suggestionView;
    }
}

#pragma mark - Public methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _field) {
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _field) {
        [self removeSuggestionView];
    }
}

- (void)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField != _field) {
        return;
    }
    if (![textField.text rangeExists:range]) {
        return;
    }
    
    // generate hints
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *hints = [self getHintsForPrefix:resultString];
    self.suggestionView.suggestions = hints;
    
    // reloads suggestionView:
    [self removeSuggestionView];
    [self showSuggestionView];
}

#pragma mark - SuggestionView stuff

- (void)showSuggestionView {
    if (self.suggestionView.suggestions.count > 0) {

        if ([self.field isFirstResponder]) {
            [self.field resignFirstResponder];
            
            self.field.inputAccessoryView = self.suggestionView;
            self.field.autocorrectionType = UITextAutocorrectionTypeNo;
            [self.field reloadInputViews];
            
            [self.field becomeFirstResponder];
        }
    }
}

- (void)removeSuggestionView {
    // Prevent calling this multiple times
    if (![self.field.inputAccessoryView isEqual:self.suggestionView]) {
        return;
    }
    
    self.field.inputAccessoryView = nil;
    
    // enables native OS autocompletion
    if ([self.field isFirstResponder]) {
        [self.field resignFirstResponder];
        
        _suggestionView = nil;
        self.field.inputAccessoryView = nil;
        self.field.autocorrectionType = UITextAutocorrectionTypeYes;
        [self.field reloadInputViews];
        
        [self.field becomeFirstResponder];
    }
}

#pragma mark SuggestionViewDelegate

- (void)suggestionSelected:(NSString *)suggestion {
    self.field.text = [NSString stringWithFormat:@"%@ ", suggestion];
    [self removeSuggestionView];
}

#pragma mark - Hints from DB

/// Returns @[NSString] or empty array @[] if no suggestions
- (NSArray *)getHintsForPrefix:(NSString *)prefix {
    Database *database = [Database sharedInstance];
    NSArray *hints = _forReceipts ? [database hintForReceiptBasedOnEntry:prefix] : [database hintForTripBasedOnEntry:prefix];
    return hints;
}

@end
