#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ButtonCell;

@protocol ButtonCellDelegate <NSObject>

@required
- (void)buttonCell:(ButtonCell *)cell didTouchUp:(bool)touchUp;

@end

@interface ButtonCell : UITableViewCell

@property (nonatomic, weak, nullable) id <ButtonCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)hideActivityIndicator;

@end

NS_ASSUME_NONNULL_END
