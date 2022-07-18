#import <UIKit/UIKit.h>
#import "BrowsePageCell.h"
#import "ButtonCell.h"
#import "ConversionCell.h"
#import "PurchaseCell.h"
#import "TextFieldCell.h"
#import "SwitchCell.h"
#import "Showcase1ViewController.h"
#import "Showcase2ViewController.h"

@import HowtankWidgetSwift;

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, ButtonCellDelegate, TextFieldCellDelegate, BrowsePageCellDelegate, ConversionCellDelegate, PurchaseCellDelegate, HowtankWidgetDelegate>
@end

typedef NS_ENUM(NSUInteger, WidgetActionsRows) {
    WidgetActionsRowsBrowsePage = 0,
    WidgetActionsRowsConversion,
    WidgetActionsRowsPurchase,
    WidgetActionsRowsHideWidget,
    WidgetActionsRowsOpenWidget,
    WidgetActionsRowsRemoveWidget,
    
    WidgetActionsRowsCount
};

typedef NS_ENUM(NSUInteger, AddWidgetRows) {
    AddWidgetRowsMnemonic = 0,
    AddWidgetRowsEnvironment,
    AddWidgetRowsAddWidget,
    AddWidgetRowsAddInSitu,
    
    AddWidgetRowsCount
};

