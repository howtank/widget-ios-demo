//
//  BrowsePageCell.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import "BrowsePageCell.h"

@interface BrowsePageCell ()

@end

@implementation BrowsePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _pageNameTextField) {
        [_pageUrlTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        NSString *pageUrl = _pageUrlTextField.text.length == 0 ? @"" : _pageUrlTextField.text;
        [_delegate browsePage:_pageNameTextField.text withUrl:pageUrl];
    }
    return true;
}

@end
