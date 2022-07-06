//
//  SwitchCell.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import "SwitchCell.h"

@interface SwitchCell ()

@end

@implementation SwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    [_delegate switchCell:self newSwitchValue:sender.isOn];
}

@end

