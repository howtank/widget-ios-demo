//
//  BrowsePageCell.h
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BrowsePageCell;

@protocol BrowsePageCellDelegate <NSObject>

@required
-(void)browsePage:(NSString *)name withUrl:(NSString *)url;

@end

@interface BrowsePageCell : UITableViewCell

@property (nonatomic, weak, nullable) id <BrowsePageCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *pageNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pageUrlTextField;

@end

NS_ASSUME_NONNULL_END
