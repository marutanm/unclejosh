//
//  UJHomeViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/14/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeViewController.h"

#import "UJHttpClient.h"

@interface UJHomeViewController ()
@property(nonatomic,strong) UIButton *button;
@end

@implementation UJHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    NIDPRINT(@"%@", [UJHttpClient isValid] ? @"YES" : @"NO");
    if (![UJHttpClient isValid]) {
        UIViewController *viewController = [[UIViewController alloc] init];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        textField.placeholder = @"name";
        [textField becomeFirstResponder];
        [viewController.view addSubview:textField];

        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"SEND" forState:UIControlStateNormal];
        self.button.frame = CGRectMake(110, 40, 100, 20);
        [self.button addTarget:self action:@selector(onSend:) forControlEvents:UIControlEventTouchUpInside];
        [viewController.view addSubview:self.button];

        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)onSend:(id)sender
{
    NIDPRINTMETHODNAME();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
