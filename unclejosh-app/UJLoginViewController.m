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

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"users"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString *postString = [NSString stringWithFormat:@"name=%@", _textField.text];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

    void (^onSuccess)(NSURLRequest*, NSHTTPURLResponse*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NIDPRINT(@"%@", JSON);
        [[NSUserDefaults standardUserDefaults] setValue:JSON[@"id"] forKey:@"UUID"];
        [[NSUserDefaults standardUserDefaults] setValue:JSON[@"name"] forKey:@"USERNAME"];
        [self dismissViewControllerAnimated:YES completion:nil];
    };

    void (^onFailure)(NSURLRequest*, NSHTTPURLResponse*, NSError*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NIDPRINT(@"%d", [response statusCode]);
        if ([response statusCode] == 503) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"その名前はすでに使われています" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    };
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:onSuccess failure:onFailure];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
