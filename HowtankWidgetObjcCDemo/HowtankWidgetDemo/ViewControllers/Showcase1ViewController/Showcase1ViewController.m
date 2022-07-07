//
//  Showcase1ViewController.m
//  HowtankWidgetDemo
//
//  Created by Hoa Nguyen on 05/07/2022.
//

#import "Showcase1ViewController.h"

@interface Showcase1ViewController ()

@property (nonatomic) NSString* thirdpartyName;

@end

@implementation Showcase1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_headerImageView setImage: [UIImage imageNamed:[NSString stringWithFormat:@"%@_header", _thirdpartyName]]];
    [_contentImageView setImage: [UIImage imageNamed:[NSString stringWithFormat:@"%@_1", _thirdpartyName]]];
    
    [_headerImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                    action:@selector(headerTapped:)]];
    [_contentImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                     action:@selector(contentTapped:)]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[HowtankWidget shared] browseWithShow:true pageName:@"Ma Page" pageUrl:@"/super" position:@"10 10 - -"];
}

- (void)setPicture:(NSString *)thirdpartyName {
    _thirdpartyName = thirdpartyName;
}

- (void)headerTapped:(UITapGestureRecognizer *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Remove chat?" 
                                                                   message:@"Removing the chat will end all ongoing conversations" 
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction: [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[HowtankWidget shared] remove];
        [self.navigationController popViewControllerAnimated:true];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)contentTapped:(UITapGestureRecognizer *)sender {
    Showcase2ViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"showcase2"];
    [viewController setPicture: [NSString stringWithFormat:@"%@_2", _thirdpartyName]];
    [self.navigationController pushViewController:viewController animated:true];
}

@end
