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
    
   
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
  
    if (textField.editing) {
        self.advSubmit.enabled = YES;
                if (self.publisherTF.text!=0) {
                    NSString *temp = self.publisherTF.text;
                    searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                    urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=inpublisher:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
                    self.subjectTF.enabled = NO;
                    self.isbnTF.enabled = NO;
                    self.authorTF.enabled = NO;
                    self.publisherTF.enabled=YES;
                    self.titleTF.enabled=NO;
                }
            
                if (self.subjectTF.text!=0) {
                    NSString *temp = self.subjectTF.text;
                    searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                    urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=subject:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
                    self.subjectTF.enabled = YES;
                    self.isbnTF.enabled = NO;
                    self.authorTF.enabled = NO;
                    self.publisherTF.enabled=NO;
                    self.titleTF.enabled=NO;
                }
            
                if (self.isbnTF.text!=0) {
                    NSString *temp = self.isbnTF.text;
                    searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                    urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=isbn:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
                    self.subjectTF.enabled = NO;
                    self.isbnTF.enabled = YES;
                    self.authorTF.enabled = NO;
                    self.publisherTF.enabled=NO;
                    self.titleTF.enabled=NO;
                }
        
                if (self.authorTF.text!=0) {
                    NSString *temp = self.authorTF.text;
                    searchStringavc = [temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                    urlStringavc = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=inauthor:%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchStringavc];
                    self.subjectTF.enabled = NO;
                    self.isbnTF.enabled = NO;
                    self.authorTF.enabled = YES;
                    self.publisherTF.enabled=NO;
                    self.titleTF.enabled=NO;
                }
            
                else {
                    info = [UIAlertController alertControllerWithTitle:@"Instructions" message:@"Please enter your query" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [info addAction:ok];
                }
    }
    else {
        self.advSubmit.enabled=NO;
    }
    
    
    return YES;

}

- (IBAction)infoButton:(id)sender {
#warning info button not working
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    searchStringavc = [[NSString alloc]init];
    urlStringavc = [[NSString alloc]init];
    self.advSubmit.enabled = NO;
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

