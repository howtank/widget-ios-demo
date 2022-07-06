//
//  ConversionCell.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import "ConversionCell.h"

@interface ConversionCell ()

@end

@implementation ConversionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [_delegate conversion:textField.text];
    return true;
}

@end
