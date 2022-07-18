#import "TextFieldCell.h"

@interface TextFieldCell ()

@end

@implementation TextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_inputTextfield setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *inputString = [[NSMutableString alloc] initWithString:_inputTextfield.text];
    if (range.length == 0) {
        [inputString appendString:string];
    } else if (range.length == 1) {
//        inputString = inputString.substring(to: inputString.index(inputString.startIndex, offsetBy: inputString.count - 1))
    }
    [_delegate textFieldCell:self valueChanged:inputString];
    return true;
}

- (IBAction)valueChanged:(UITextField *)sender {
    [_delegate textFieldCell:self valueChanged:sender.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [_delegate textFieldCell:self valueChanged:textField.text];
    return true;
}

@end
