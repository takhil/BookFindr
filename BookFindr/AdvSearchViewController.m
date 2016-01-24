//
//  AdvSearchViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "AdvSearchViewController.h"

@interface AdvSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *publisherTF;
@property (weak, nonatomic) IBOutlet UITextField *subjectTF;
@property (weak, nonatomic) IBOutlet UITextField *isbnTF;
@property (weak, nonatomic) IBOutlet UITextField *authorTF;
@end

@implementation AdvSearchViewController
@synthesize info;
@synthesize searchStringavc;
@synthesize urlStringavc;

- (IBAction)advSearchButton:(id)sender {
    
   if (self.publisherTF.text!=0) {
        NSString *temp = self.publisherTF.text;
        searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=inpublisher:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
    }
    
    else if (self.subjectTF.text!=0) {
        NSString *temp = self.subjectTF.text;
        searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=subject:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
    }
    
    else if (self.isbnTF.text!=0) {
        NSString *temp = self.isbnTF.text;
        searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=isbn:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
    }
    else if (self.authorTF.text!=0) {
        NSString *temp = self.authorTF.text;
        searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=inauthor:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
    }
    
    else {
        info = [UIAlertController alertControllerWithTitle:@"Instructions" message:@"Please enter your query" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [info addAction:ok];
    }
    
}


- (IBAction)infoButton:(id)sender {
#warning info button not working
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    searchStringavc = [[NSString alloc]init];
    urlStringavc = [[NSString alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.titleTF resignFirstResponder];
    [self.publisherTF resignFirstResponder];
    [self.subjectTF resignFirstResponder];
    [self.isbnTF resignFirstResponder];
    [self.authorTF resignFirstResponder];

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

