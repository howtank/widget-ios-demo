//
//  PurchaseCell.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import <UIKit/UIKit.h>
@import HowtankWidgetSwift;

NS_ASSUME_NONNULL_BEGIN

@class PurchaseCell;

@protocol PurchaseCellDelegate <NSObject>

@required
-(void)purchaseConversion:(PurchaseParameters *)purchaseParameters;

@end

@interface PurchaseCell : UITableViewCell

@property (nonatomic, weak, nullable) id <PurchaseCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *purchaseIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *purchaseValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *purchaseCurrencyTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchElement;

@end

NS_ASSUME_NONNULL_END
