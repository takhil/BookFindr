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

NSMutableArray *imageTemp;
@synthesize selfLinksArray;
@synthesize selfLinksArrayURL;
@synthesize titleArray;
@synthesize authorsArray;
@synthesize publisherArray;
@synthesize descriptionArray;
@synthesize isbn13;
@synthesize images;
@synthesize imageThumbnails;
@synthesize googleRating;
@synthesize googleRatingsCount;

- (void)viewDidLoad {
    [super viewDidLoad];
   
//Declaring arrays
    NSMutableArray *tempArray = selfLinksArray[0];
    titleArray = [[NSMutableArray alloc]init];
    authorsArray = [[NSMutableArray alloc]init];
    publisherArray = [[NSMutableArray alloc]init];
    descriptionArray = [[NSMutableArray alloc]init];
    isbn13 = [[NSMutableArray alloc]init];
    imageThumbnails =[[NSMutableArray alloc]init];
    images = [[NSMutableArray alloc]init];
    googleRating =[[NSMutableArray alloc]init];
    googleRatingsCount = [[NSMutableArray alloc]init];
    
//Declaring temporary arrays
   imageTemp =[[NSMutableArray alloc]init];
    
//extracting cell parameters
    for (int i=0; i<10; i++) {
//          NSString *temp = selfLinksArray[i];
        NSURL *tempURL = [NSURL URLWithString:tempArray[i]];
      NSLog(@"NSURL:%@",tempURL);
//          selfLinksArrayURL[i] = tempURL;
//          NSLog(@"SelfLinksArrayURL:%@", selfLinksArrayURL);
        NSData *tempData = [NSData dataWithContentsOfURL:tempURL];
        NSError *error = nil;
        NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:&error];
          NSLog(@"TempDict:%@",tempDict);
        NSDictionary *volumeInfoDict = [tempDict objectForKey:@"volumeInfo"];
          NSLog(@"Title:%@",[volumeInfoDict objectForKey:@"title"]);
       
//Authors extraction
#warning Author should be extracted in a separate method
        NSMutableArray *temparr1 = [tempDict objectForKey:@"author"];

        
//Titles extraction
        [titleArray addObject:[volumeInfoDict objectForKey:@"title"]];

//Publisher extraction
        NSString *check = [volumeInfoDict objectForKey:@"publisher"];
        if ([check isEqualToString:@""]) {
            [publisherArray addObject:@"N/A"];
        }
        else {
            
            [publisherArray addObject:[volumeInfoDict objectForKey:@"publisher"]];
        }
//Description Extraction
        if ([volumeInfoDict objectForKey:@"description"] !=0) {
            [descriptionArray addObject:[volumeInfoDict objectForKey:@"description"]];
           }
        else {
            [descriptionArray addObject:@"N/A"];
        }
//ISBN Number extraction
        NSMutableArray *industrialIdentifiers = [volumeInfoDict objectForKey:@"industryIdentifiers"];
        NSMutableDictionary *ISBN13 = industrialIdentifiers[1];
        
        if ([ISBN13 objectForKey:@"identifier"]!=0) {
            [isbn13 addObject:[ISBN13 objectForKey:@"identifier"]];
        }
        else {
            [isbn13 addObject:@"N/A"];
        }
//Google Rating extraction
        if ([volumeInfoDict objectForKey:@"averageRating"]!=0) {
            [googleRating addObject:[volumeInfoDict objectForKey:@"averageRating"]];
        }
        else {
            [googleRating addObject:@"N/A"];
        }
        
        
//Google ratings count extraction
        if ( [volumeInfoDict objectForKey:@"ratingsCount"]!=0) {
             [googleRatingsCount addObject:[volumeInfoDict objectForKey:@"ratingsCount"]];
        }
        else {
            [googleRatingsCount addObject:@"N/A"];
        }
       
        
//Image thumbnails extraction
        NSMutableDictionary *tempdd = [volumeInfoDict objectForKey:@"imageLinks"];
        [imageTemp addObject:[tempdd objectForKey:@"smallThumbnail"]] ;
        NSString *imageString = imageTemp[i];
        NSURL *imageURL = [NSURL URLWithString:imageString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        [imageThumbnails addObject:image];
        }
    
  NSLog(@"UserRating:%@",googleRating);
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
    customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.bookTitle.text = titleArray[indexPath.row];
    cell.publisherBook.text = publisherArray[indexPath.row];
    
    cell.bookImage.image = imageThumbnails[indexPath.row];
    
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
