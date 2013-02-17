//
//  UJLoginViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/15/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJLoginViewController.h"

#import "UJHttpClient.h"

@interface UJLoginViewController ()

@property(nonatomic) UITextField *textField;
@property(nonatomic) UIButton *button;

@end

@implementation UJLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        _textField.placeholder = @"name";
        _textField.autocapitalizationType = UITextAutocorrectionTypeNo;
        [_textField becomeFirstResponder];

        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button setTitle:@"SEND" forState:UIControlStateNormal];
        _button.frame = CGRectMake(110, 40, 100, 20);
        [_button addTarget:self action:@selector(onSend:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:_textField];
    [self.view addSubview:_button];
}

- (void)onSend:(id)sender
{
    NIDPRINT(@"%@", _textField.text);

    [[UJHttpClient sharedClient] registerUser:_textField.text onSuccess:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
