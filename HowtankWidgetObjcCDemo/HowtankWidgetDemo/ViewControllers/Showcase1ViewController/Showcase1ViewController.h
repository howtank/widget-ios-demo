#import <UIKit/UIKit.h>
#import "Showcase2ViewController.h"
@import HowtankWidgetSwift;

NS_ASSUME_NONNULL_BEGIN

@interface Showcase1ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

- (void)setPicture:(NSString *)thirdpartyName;

@end

NS_ASSUME_NONNULL_END
