//
//  Showcase2ViewController.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 05/07/2022.
//

#import <UIKit/UIKit.h>
@import HowtankWidgetSwift;
NS_ASSUME_NONNULL_BEGIN

@interface Showcase2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

- (void)setPicture:(NSString *)pictureName;

@end

NS_ASSUME_NONNULL_END
