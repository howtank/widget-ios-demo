//
//  TextFieldCell.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TextFieldCell;

@protocol TextFieldCellDelegate <NSObject>

@required
- (void)textFieldCell:(TextFieldCell *)cell valueChanged:(NSString *)newValue;

@end

@interface TextFieldCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, weak, nullable) id <TextFieldCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *inputTextfield;

@end

NS_ASSUME_NONNULL_END
