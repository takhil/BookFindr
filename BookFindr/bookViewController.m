//
//  bookViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "bookViewController.h"
#import "tabResTableViewController.h"

@interface bookViewController ()


@end

@implementation bookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookImageView.image = self.Image;
    self.bookDescription.text =self.Description;
    self.bookDescription.textAlignment = NSTextAlignmentCenter;
    self.bookPublisher.text = self.Publisher;
    self.bookTitle.text = self.Title;
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
