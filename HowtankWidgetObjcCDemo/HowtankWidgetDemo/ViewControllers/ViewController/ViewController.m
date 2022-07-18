//
//  ViewController.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 30/06/2022.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) bool isWidgetAdded;

@property (nonatomic) bool isBrowsePageCellExpanded;
@property (nonatomic) bool isConversionCellExpanded;
@property (nonatomic) bool isPurchaseCellExpanded;
@property (nonatomic) bool environmentIsProd;
@property (nonatomic) bool addWidgetInSitu;

@property (nonatomic) NSString *hostMnemonic;
@property (nonatomic) NSString *thirdPartyName;

@property (nonatomic) NSInteger numberOfLinksClicked;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;

@property (nonatomic) ButtonCell* addButtonCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    _isWidgetAdded = false;
    _isBrowsePageCellExpanded = false;
    _isConversionCellExpanded = false;
    _isPurchaseCellExpanded = false;
    _environmentIsProd = false;
    _addWidgetInSitu = false;
    _numberOfLinksClicked = 0;
    _hostMnemonic = @"blablacar";
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillChangeFrame:) name: UIKeyboardWillChangeFrameNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PurchaseCell" bundle:nil] forCellReuseIdentifier:@"PurchaseCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ConversionCell" bundle:nil] forCellReuseIdentifier:@"ConversionCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BrowsePageCell" bundle:nil] forCellReuseIdentifier:@"BrowsePageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:nil] forCellReuseIdentifier:@"ButtonCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"TextFieldCell" bundle:nil] forCellReuseIdentifier:@"TextFieldCell"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIKeyboardWillChangeFrameNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIKeyboardWillHideNotification object: nil];    
}

- (void)keyboardWillChangeFrame:(NSNotification *) notification {
    NSDictionary *info = notification.userInfo;
    NSValue *keyboardFrameEnd = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameEnd CGRectValue];
    UIWindow *window = [[self view] window];
    CGRect keyboardViewEndFrame = [[self view] convertRect:keyboardFrameBeginRect fromView:window];
    CGRect keyboardFrame = CGRectIntersection(self.view.bounds, keyboardViewEndFrame);
    _tableViewBottomConstraint.constant = keyboardFrame.size.height;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

- (void)keyboardWillHide:(NSNotification *) notification {
    _tableViewBottomConstraint.constant = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _isWidgetAdded ? WidgetActionsRowsCount : AddWidgetRowsCount;
}

- (ButtonCell *)dequeButtonCellWithTitle:(NSString *)title tag:(NSInteger)tag atIndexPath:(NSIndexPath *)indexPath {
    ButtonCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
    [cell setTag:tag];
    [[cell button] setTitle:title forState:UIControlStateNormal];
    [cell setDelegate:(id)self];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isWidgetAdded) {
        switch (indexPath.row) {
            case WidgetActionsRowsBrowsePage:
                if (_isBrowsePageCellExpanded) {
                    BrowsePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrowsePageCell" forIndexPath:indexPath];
                    [[cell pageNameTextField] becomeFirstResponder];
                    [cell setDelegate:(id)self];
                    return cell;
                } 
                return [self dequeButtonCellWithTitle:@"Browse page" tag:WidgetActionsRowsBrowsePage atIndexPath:indexPath];
                break;
                
            case WidgetActionsRowsConversion:
                if (_isBrowsePageCellExpanded) {
                    ConversionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversionCell" forIndexPath:indexPath];
                    [[cell conversionTypeTextField] becomeFirstResponder];
                    [cell setDelegate:(id)self];
                    return cell;
                }
                return [self dequeButtonCellWithTitle:@"Conversion" tag:WidgetActionsRowsConversion atIndexPath:indexPath];
                break;
                
            case WidgetActionsRowsPurchase:
                if (_isBrowsePageCellExpanded) {
                    PurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseCell" forIndexPath:indexPath];
                    [[cell purchaseIdTextField] becomeFirstResponder];
                    [cell setDelegate:(id)self];
                    return cell;
                }
                return [self dequeButtonCellWithTitle:@"Purchase" tag:WidgetActionsRowsPurchase atIndexPath:indexPath];
                break;
                
            case WidgetActionsRowsHideWidget:
                return [self dequeButtonCellWithTitle:@"Hide Widget" tag:WidgetActionsRowsHideWidget atIndexPath:indexPath];
                break;
                
            case WidgetActionsRowsOpenWidget:
                return [self dequeButtonCellWithTitle:@"Open Widget" tag:WidgetActionsRowsOpenWidget atIndexPath:indexPath];
                break;
            case WidgetActionsRowsRemoveWidget: {
                ButtonCell *cell = [self dequeButtonCellWithTitle:@"Remove Widget" tag:WidgetActionsRowsRemoveWidget atIndexPath:indexPath];
                [[cell button] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [[cell button] setBackgroundColor:[UIColor clearColor]];
                return cell;
                break;
            }
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case AddWidgetRowsMnemonic: {
                TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
                [cell setDelegate:(id)self];
                [[cell inputTextfield] setText:_hostMnemonic];
                return cell;
                break;
            }
                
            case AddWidgetRowsEnvironment: {
                SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
                [cell setDelegate:(id)self];
                [cell setTag:AddWidgetRowsEnvironment];
                [[cell switchElement] setOn:_environmentIsProd];
                break;
            }
                
            case AddWidgetRowsAddWidget:
                return [self dequeButtonCellWithTitle:@"Add Widget" tag:AddWidgetRowsAddWidget atIndexPath:indexPath];
                break;
            case AddWidgetRowsAddInSitu:
                return [self dequeButtonCellWithTitle:@"Add Widget in Situ" tag:AddWidgetRowsAddInSitu atIndexPath:indexPath];
                break;
            default:
                break;
        }
    }
    return [UITableViewCell new];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _isWidgetAdded ? @"Widget actions" : @"Add widget";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isWidgetAdded) {
        if (indexPath.row == WidgetActionsRowsBrowsePage && _isBrowsePageCellExpanded) {
            return 102;
        } else if (indexPath.row == WidgetActionsRowsPurchase && _isPurchaseCellExpanded) {
            return 182;
        }
    }
    return 62;
}

- (void)switchCell:(SwitchCell *)cell newSwitchValue:(bool)switchIsOn {
    if (cell.tag == AddWidgetRowsEnvironment) {
        _environmentIsProd = switchIsOn;
    }
}

- (void)textFieldCell:(TextFieldCell *)cell valueChanged:(NSString *)newValue {
    _hostMnemonic = newValue;
}

- (void)buttonCell:(ButtonCell *)cell didTouchUp:(bool)touchUp {
    if (_isWidgetAdded) {
        switch (cell.tag) {
            case WidgetActionsRowsRemoveWidget:
                [[HowtankWidget shared] remove];
                _isWidgetAdded = false;
                _isBrowsePageCellExpanded = false;
                _isConversionCellExpanded = false;
                _isPurchaseCellExpanded = false;
                [_tableView reloadData];
                break;
                
            case WidgetActionsRowsBrowsePage:
                _isBrowsePageCellExpanded = true;
                [_tableView reloadData];
                break;
                
            case WidgetActionsRowsConversion:
                _isConversionCellExpanded = true;
                [_tableView reloadData];
                break;
                
            case WidgetActionsRowsPurchase:
                _isPurchaseCellExpanded = true;
                [_tableView reloadData];
                break;
            case WidgetActionsRowsHideWidget:
                [_tableView reloadData];
                break;
                
            case WidgetActionsRowsOpenWidget:
                [[HowtankWidget shared] open];
                [_tableView reloadData];
                break;
                
            default:
                break;
        }
    } else {
        if (!_addButtonCell) {
            _addButtonCell = cell;
            switch (cell.tag) {
                case AddWidgetRowsAddWidget:
                    _addWidgetInSitu = false;
                    [self addWidget];
                    break;
                    
                case AddWidgetRowsAddInSitu: {
                    self->_thirdPartyName = @"monapp";
                    self->_addWidgetInSitu = true;
                    [self addWidget];
                    break;
                }
            }
        }
    }
}

- (void)addWidget {
    [[[[[HowtankWidget shared] verboseMode:true] usingSandboxPlatform:_environmentIsProd] disablingWidgetRequiresValidation:true] configureWithHostId:_hostMnemonic delegate:(id)self];
    
    if (_addWidgetInSitu) {
        Showcase1ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"showcase1"];
        [vc setPicture:_thirdPartyName];
        [self.navigationController pushViewController:vc animated:true];
    } else {
        [[HowtankWidget shared] browseWithShow:false pageName:@"Hello" pageUrl:@"/hello" position:nil];
    }
}

- (void)browsePage:(NSString *)name withUrl:(NSString *)url {
    [[HowtankWidget shared] browseWithShow:false pageName:name pageUrl:url position:nil];
    _isBrowsePageCellExpanded = false;
    [_tableView reloadData];
}

- (void)conversion:(NSString *)type {
    [[HowtankWidget shared] conversionWithName:type purchaseParameters:nil];
    _isConversionCellExpanded = false;
    [_tableView reloadData];
}

- (void)purchaseConversion:(PurchaseParameters *)purchaseParameters {
    PurchaseParameters* parameters = [[PurchaseParameters alloc] initWithNewBuyer:true 
                                                                               purchaseId:@"PURCHASE_ID" 
                                                                              valueAmount:12.8 
                                                                            valueCurrency:HowtankCurrencyEuro];
    [[HowtankWidget shared] conversionWithName:@"purchase" purchaseParameters:parameters];
    _isPurchaseCellExpanded = false;
    [_tableView reloadData];
}

- (void)widgetEventWithEvent:(enum WidgetEventType)event paramaters:(NSDictionary<NSString *,id> *)paramaters {
    switch (event) {
        case WidgetEventTypeInitialized:
            [_addButtonCell hideActivityIndicator];
            _addButtonCell = nil;
            if (!_addWidgetInSitu) {
                _isWidgetAdded = true;
                [_tableView reloadData];
            }
            break;
        
        case WidgetEventTypeOpened:
            NSLog(@"open");
            break;
            
        case WidgetEventTypeDisabled:
            NSLog(@"Disabled");
            _isWidgetAdded = false;
            if (!_addWidgetInSitu) {
                _isBrowsePageCellExpanded = false;
                _isConversionCellExpanded = false;
                _isPurchaseCellExpanded = false;
                [_tableView reloadData];
            } else {
                [[self navigationController] popToRootViewControllerAnimated:true];
            }
            break;
            
        case WidgetEventTypeDisplayed:
            NSLog(@"Displayed");
            break;
            
        case WidgetEventTypeHidden:
            NSLog(@"Hidden");
            break;
        
        case WidgetEventTypeClosed: {
            bool chatClosed = paramaters[@"chatClosed"];
            NSLog(@"Close%d", chatClosed);
            break;
        }
            
        case WidgetEventTypeLinkSelected:
            
            if (_thirdPartyName) {
                Showcase2ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"showcase2"];
                [vc setPicture: [NSString stringWithFormat:@"%@_%ld", _thirdPartyName, _numberOfLinksClicked%1+2]];
                [[self navigationController] pushViewController:vc animated:true];
                [[HowtankWidget shared] collapse];
            } else {
                NSString *link = [paramaters valueForKey:@"link"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Link clicked" message:link preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            }
            _numberOfLinksClicked += 1;
            break;
            
        case WidgetEventTypeUnavailable: {
            [_addButtonCell hideActivityIndicator];
            _addButtonCell = nil;
            [[HowtankWidget shared] conversionWithName:@"type" purchaseParameters:nil];
            
            
            NSString *reason = [paramaters valueForKey:@"reason"];
            if ([reason isEqualToString:@"Widget disabled"]) {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Widget has been previously disabled" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [alertController addAction: [UIAlertAction actionWithTitle:@"Enable" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [[HowtankWidget shared] enabled];
                }]];  
                [self presentViewController:alertController animated:true completion:nil];
            } else {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error" message:reason preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:true completion:nil];
                [[HowtankWidget shared] remove];
            }
            break;
        }
        case WidgetEventTypeScoredInterlocutor: {
            NSString *note = paramaters[@"note"];
            NSLog(@"ScoredInterlocutor-%@", note);
            break;
        }
        
        default:
            break;
    }
}

@end
