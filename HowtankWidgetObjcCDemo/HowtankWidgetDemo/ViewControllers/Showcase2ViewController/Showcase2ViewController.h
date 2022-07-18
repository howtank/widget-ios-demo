#import <UIKit/UIKit.h>
@import HowtankWidgetSwift;
NS_ASSUME_NONNULL_BEGIN

@interface Showcase2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

- (void)setPicture:(NSString *)pictureName;

@end

NS_ASSUME_NONNULL_END
