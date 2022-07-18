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
