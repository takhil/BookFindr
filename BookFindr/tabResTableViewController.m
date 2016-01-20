//
//  tabResTableViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "tabResTableViewController.h"

@interface tabResTableViewController ()

@end

@implementation tabResTableViewController


@synthesize selfLinksArray;
@synthesize selfLinksArrayURL;
@synthesize titleArray;
@synthesize authorsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tempArray = selfLinksArray[0];
    NSLog(@"SelfLinksArray:%@", selfLinksArray);
    titleArray = [[NSMutableArray alloc]init];
    authorsArray = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
       //   NSString *temp = selfLinksArray[i];
        NSURL *tempURL = [NSURL URLWithString:tempArray[i]];
    //      NSLog(@"NSURL:%@",tempURL);
//          selfLinksArrayURL[i] = tempURL;
//          NSLog(@"SelfLinksArrayURL:%@", selfLinksArrayURL);
        NSData *tempData = [NSData dataWithContentsOfURL:tempURL];
        NSError *error = nil;
        NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:&error];
      //    NSLog(@"TempDict:%@",tempDict);
        NSDictionary *volumeInfoDict = [tempDict objectForKey:@"volumeInfo"];
       //   NSLog(@"Title:%@",[volumeInfoDict objectForKey:@"title"]);
        NSMutableArray *temparr1 = [tempDict objectForKey:@"author"];
        [titleArray addObject:[volumeInfoDict objectForKey:@"title"]];
}
    
  NSLog(@"TitleArray:%@",titleArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
