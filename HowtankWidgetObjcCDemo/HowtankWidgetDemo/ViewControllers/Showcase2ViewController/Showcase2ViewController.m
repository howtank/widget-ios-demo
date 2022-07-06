//
//  Showcase2ViewController.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 05/07/2022.
//

#import "Showcase2ViewController.h"

@interface Showcase2ViewController ()
@property (nonatomic) NSString* pictureName;
@end

@implementation Showcase2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_contentImageView setImage: [UIImage imageNamed:_pictureName]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[HowtankWidget shared] browseWithShow:false pageName:@"" pageUrl:nil position:nil];
}

- (void)setPicture:(NSString *)pictureName {
    _pictureName = pictureName;
}

- (IBAction)clicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
