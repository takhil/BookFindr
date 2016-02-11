//
//  ViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/16/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"


@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end

@implementation ViewController
@synthesize searchString;
@synthesize dictSearch;
@synthesize booksArray;
- (IBAction)buttonSubmit:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if (self.searchText.text.length!=0) {
        NSString *temp = self.searchText.text;
        searchString =[temp stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *urlString = [[NSString alloc] initWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=%@&key=AIzaSyCg-cr3wsxUWjgZNSEzAsQHVqB3eZ97QFQ",searchString];
        NSLog(@"UrlString:%@",urlString);
        NSURL *basicURL = [NSURL URLWithString:urlString];
        NSData *basicData = [NSData dataWithContentsOfURL:basicURL];
        NSError *error = nil;
        dictSearch = [NSJSONSerialization JSONObjectWithData:basicData options:0 error:&error];
        //NSLog(@"dictsearch:%@",dictSearch);
        booksArray = [[NSMutableArray alloc]initWithObjects:[dictSearch valueForKey:@"items"] , nil];
        // NSLog(@"Books Array: %@",booksArray);
        for(NSDictionary* item in booksArray) {
            // NSLog(@"Titles: %@",[item valueForKey:@"selfLink"]);
            _tempArray = [ [NSMutableArray alloc] initWithObjects:[item valueForKey:@"selfLink"], nil];
            }
        
    }
    
    else {
        UIAlertController *incompleteText = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please enter your search query!" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:incompleteText animated:YES completion:nil ];
        UIAlertAction *ok = [ UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [incompleteText addAction:ok];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.searchText becomeFirstResponder];
   
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 30) {
        UIAlertController *maxInput = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Maximum input reached!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [maxInput addAction:ok];
        self.searchText.text  = @"";
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchText resignFirstResponder];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"basicSearchSegue"]){
     UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
     tabResTableViewController *trtvc = (tabResTableViewController *)navController;
     trtvc.selfLinksArray = _tempArray;
    }
}
@end
