//
//  PurchaseCell.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import "PurchaseCell.h"

@interface PurchaseCell ()

@end

@implementation PurchaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _purchaseIdTextField) {
        [_purchaseValueTextField becomeFirstResponder];
//        [HowtankWidget ]
    } else if (textField == _purchaseValueTextField) {
        [_purchaseCurrencyTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        PurchaseParameters *purchaseParameters = [[PurchaseParameters alloc] initWithNewBuyer:_switchElement.isOn 
                                                                                   purchaseId:_purchaseIdTextField.text
                                                                                  valueAmount:[[NSNumberFormatter new] numberFromString:_purchaseValueTextField.text].doubleValue 
                                                                          customValueCurrency:_purchaseCurrencyTextField.text
        ];
        [_delegate purchaseConversion:purchaseParameters];
    }
    return true;
}

@end
