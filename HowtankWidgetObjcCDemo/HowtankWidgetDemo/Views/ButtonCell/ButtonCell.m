#import "ButtonCell.h"

@interface ButtonCell ()

@end

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_button.layer setCornerRadius:5];
    [_activityIndicator setHidden:true];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_activityIndicator setHidden:true];
}

- (void)hideActivityIndicator {
    [_activityIndicator setHidden:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)touchedUp:(UIButton *)sender {
    [_delegate buttonCell:self didTouchUp:true];
    [_activityIndicator setHidden:false];
    [_activityIndicator startAnimating];
}

@end
