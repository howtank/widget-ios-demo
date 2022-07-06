//
//  ConversionCell.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ConversionCell;

@protocol ConversionCellDelegate <NSObject>

@required
-(void)conversion:(NSString *)type;

@end

@interface ConversionCell : UITableViewCell

@property (nonatomic, weak, nullable) id <ConversionCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *conversionTypeTextField;

@end

NS_ASSUME_NONNULL_END
