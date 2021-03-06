//
//  TitledTextEntryCell.h
//  SmartReceipts
//
//  Created by Jaanus Siim on 30/04/15.
//  Copyright (c) 2015 Will Baumann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEntryCell.h"

@interface TitledTextEntryCell : TextEntryCell

- (void)setTitle:(NSString *)title;
- (void)setPlaceholder:(NSString *)placeholder;

@end
