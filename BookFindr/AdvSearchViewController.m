//
//  AdvSearchViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "AdvSearchViewController.h"

@interface AdvSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *publisherTF;
@property (weak, nonatomic) IBOutlet UITextField *subjectTF;
@property (weak, nonatomic) IBOutlet UITextField *isbnTF;
@property (weak, nonatomic) IBOutlet UITextField *authorTF;
@end

@implementation AdvSearchViewController
- (IBAction)advSearchButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
