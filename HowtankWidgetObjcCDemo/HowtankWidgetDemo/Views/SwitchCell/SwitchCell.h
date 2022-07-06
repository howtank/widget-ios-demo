//
//  SwitchCell.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

@required
-(void)switchCell:(SwitchCell *)cell newSwitchValue:(bool)switchIsOn;

@end

@interface SwitchCell : UITableViewCell

@property (nonatomic, weak, nullable) id <SwitchCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *switchElement;

@end

NS_ASSUME_NONNULL_END
