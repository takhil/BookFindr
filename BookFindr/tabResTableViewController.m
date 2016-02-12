//
//  tabResTableViewController.m
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import "tabResTableViewController.h"
#import "bookViewController.h"
#import "NSString_stripHtml.h"
#import "AmazonAuthUtils.h"
#import "PicoXMLElement.h"
#import "AWSECommerceServiceClient.h"

@interface tabResTableViewController ()


@end

@implementation tabResTableViewController


//Google Books API Properties
NSMutableArray *imageTempThumbnail;
NSMutableArray *imageTemp;
@synthesize selfLinksArray;
@synthesize titleArray;
@synthesize authorsArray;
@synthesize publisherArray;
@synthesize descriptionArray;
@synthesize isbn13;
@synthesize images;
@synthesize imageThumbnails;
@synthesize googleRating;
@synthesize googleRatingsCount;
@synthesize authorsString;
@synthesize ISBN13;
@synthesize saleInfoDict;

//Google Books Properties
@synthesize googleListPrices;
@synthesize googleRetailPrices;

//Apple Properties
@synthesize UrlApple;
@synthesize UrlStringApple;
@synthesize AppleData;
@synthesize AppleDict;
@synthesize applePrices;

- (void)viewDidLoad {
    [super viewDidLoad];
   
//Declaring arrays
    NSMutableArray *tempArray = selfLinksArray[0];
    NSMutableDictionary *tempdd = [[NSMutableDictionary alloc]init];
    titleArray = [[NSMutableArray alloc]init];
    authorsArray = [[NSMutableArray alloc]init];
    publisherArray = [[NSMutableArray alloc]init];
    descriptionArray = [[NSMutableArray alloc]init];
    isbn13 = [[NSMutableArray alloc]init];
    imageThumbnails =[[NSMutableArray alloc]init];
    images = [[NSMutableArray alloc]init];
    googleRating =[[NSMutableArray alloc]init];
    googleRatingsCount = [[NSMutableArray alloc]init];
    authorsString = [[NSString alloc]init];
    ISBN13 = [[NSMutableDictionary alloc]init];
    saleInfoDict = [[NSMutableDictionary alloc]init];
    googleListPrices = [[NSMutableArray alloc]init];
    googleRetailPrices = [[NSMutableArray alloc]init];
    applePrices = [[NSMutableArray alloc]init];
    
 //Default images
    UIImage *imagena = [UIImage imageNamed:@"imagena.png"];
  //  UIImage *imagena1 = [UIImage imageNamed:@"imagena1.png"];
    
//Declaring temporary arrays
    imageTempThumbnail =[[NSMutableArray alloc]init];
    imageTemp = [[NSMutableArray alloc]init];
    
//Amazon Parameters
    static NSString *const AWSECServiceURLString = @"https://webservices.amazon.com/onca/soap?Service=AWSECommerceService";
    
    NSString *const AWSAccessKeyId = @"AKIAJ2FPO6ZEYWE5R4TQ";
    NSString *const AWSSecureKeyId = @"";
    
    static NSString *const AuthHeaderNS = @"http://security.amazonaws.com/doc/2007-01-01/";

    
//extracting cell parameters
    for (int i=0; i<tempArray.count; i++) {

        NSURL *tempURL = [NSURL URLWithString:tempArray[i]];
        NSData *tempData = [NSData dataWithContentsOfURL:tempURL];
        NSError *error = nil;
        NSMutableDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:&error];
       //   NSLog(@"TempDict:%@",tempDict);
        NSMutableDictionary *volumeInfoDict = [tempDict objectForKey:@"volumeInfo"];
        saleInfoDict = [tempDict objectForKey:@"saleInfo"];
        //  NSLog(@"Title:%@",[volumeInfoDict objectForKey:@"title"]);
       
//Authors extraction
        if ([volumeInfoDict objectForKey:@"authors"]!=0) {
            NSMutableArray *temparr1 = [volumeInfoDict objectForKey:@"authors"];
            authorsString = [temparr1 componentsJoinedByString:@", "];
            [authorsArray addObject:authorsString];
            authorsString = @"";
        }
        else {
            authorsString = @"N/A";
            [authorsArray addObject:authorsString];
            authorsString = @"";
        }
        
//Titles extraction
        if ([volumeInfoDict objectForKey:@"title"]!=0) {
            [titleArray addObject:[volumeInfoDict objectForKey:@"title"]];

        }
        else {
            [titleArray addObject:@"N/A"];
        }
//Publisher extraction
        if ([volumeInfoDict objectForKey:@"publisher"]!=0) {
            
            [publisherArray addObject:[volumeInfoDict objectForKey:@"publisher"]];
            
        }
        
        else {
            [publisherArray addObject:@"N/A"];
        }

//Description Extraction
        if ([volumeInfoDict objectForKey:@"description"] !=0) {
            [descriptionArray addObject:[volumeInfoDict objectForKey:@"description"]];
           }
        else {
            [descriptionArray addObject:@"N/A"];
        }
//ISBN Number extraction
        if ([volumeInfoDict objectForKey:@"industryIdentifiers"]!=0) {
            NSMutableArray *industrialIdentifiers = [volumeInfoDict objectForKey:@"industryIdentifiers"];
            
            if (industrialIdentifiers[1]!=0) {
                ISBN13 = industrialIdentifiers[1];
                
                if ([ISBN13 objectForKey:@"identifier"]!=0) {
                    [isbn13 addObject:[ISBN13 objectForKey:@"identifier"]];
                }
                else {
                    [isbn13 addObject:@"N/A"];
                }
            }
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
      
        
// Prices Extraction
        //Google
        
        if ([saleInfoDict objectForKey:@"listPrice"]!=0) {
            NSMutableDictionary *listPriceDict = [saleInfoDict objectForKey:@"listPrice"];
            if ([listPriceDict objectForKey:@"amount"]!=0) {
                [googleListPrices addObject:[listPriceDict objectForKey:@"amount"]];
            }
            else{
                [googleListPrices addObject:@"N/A"];
            }
        }
        else {
            [googleListPrices addObject:@"N/A"];
        }
       
        if ([saleInfoDict objectForKey:@"retailPrice"]!=0) {
            NSMutableDictionary *retailPriceDict = [saleInfoDict objectForKey:@"retailPrice"];
            if ([retailPriceDict objectForKey:@"amount"]!=0) {
                [googleRetailPrices addObject:[retailPriceDict objectForKey:@"amount"]];
            }
            else{
                [googleRetailPrices addObject:@"N/A"];
            }
        }
        else{
            [googleRetailPrices addObject:@"N/A"];
        }
        
        
        
//Image thumbnails extraction
        if ([volumeInfoDict objectForKey:@"imageLinks"]!=0) {
           tempdd = [volumeInfoDict objectForKey:@"imageLinks"];
            
            if ([tempdd objectForKey:@"smallThumbnail"]!=0) {
                NSString *imageString = [[NSString alloc]init ];
                imageString = [tempdd objectForKey:@"smallThumbnail"];
                NSURL *imageURL = [NSURL URLWithString:imageString];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                UIImage *image = [UIImage imageWithData:imageData];
                [imageThumbnails addObject:image];
            }
            else {
                [imageThumbnails addObject:imagena];
            }
        }
        else{
            [imageThumbnails addObject:imagena];
        }
       
//Apple Prices and URL extraction
        NSLog(@"isbn13:%@",isbn13);
        if ( [isbn13[i] isEqualToString:@"N/A"]){
        }
        else {
            UrlStringApple = [[NSString alloc]initWithFormat:@"https://itunes.apple.com/lookup?isbn=%@",isbn13[i]];
            UrlApple =[NSURL URLWithString:UrlStringApple] ;
            AppleData = [NSData dataWithContentsOfURL:UrlApple];
            AppleDict = [NSJSONSerialization JSONObjectWithData:AppleData options:0 error:nil];
            NSDictionary *resultsDict = [[NSDictionary alloc]init];
            NSMutableArray *resultsArray = [AppleDict objectForKey:@"results"];
            if ([resultsArray count]!=0) {
                resultsDict = resultsArray[0];
                if ([resultsDict objectForKey:@"formattedPrice"]!=0) {
                    [applePrices addObject:[resultsDict objectForKey:@"formattedPrice"]];
                }
                else {
                    [applePrices addObject:@"N/A"];
                }
                
            }
            else {
                [applePrices addObject:@"N/A"];
            }
            }
        
//Amazon Prices and URL extraction
        
        // build timestamp
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init] ;
        [dataFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [dataFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Eastern"]];
        NSString *timestamp = [dataFormatter stringFromDate:[NSDate date]];
        
        // build signature
        NSString *signatureInput = timestamp;
        NSString *signature = [AmazonAuthUtils sha256HMac:[signatureInput dataUsingEncoding:NSUTF8StringEncoding] withKey:@"AKIAJ2FPO6ZEYWE5R4TQ"];
        
        // add SOAP headers
        NSMutableArray *customSoapHeaders = [[NSMutableArray alloc]init];
        PicoXMLElement *accessKeyElement = [[PicoXMLElement alloc] init] ;
        accessKeyElement.nsUri = AuthHeaderNS;
        accessKeyElement.name = @"AWSAccessKeyId";
        accessKeyElement.value = AWSAccessKeyId;
      [customSoapHeaders addObject:accessKeyElement];
        PicoXMLElement *timestampElement = [[PicoXMLElement alloc] init] ;
        timestampElement.nsUri = AuthHeaderNS;
        timestampElement.name = @"Timestamp";
        timestampElement.value = timestamp;
       [customSoapHeaders addObject:timestampElement];
        PicoXMLElement *signatureElement = [[PicoXMLElement alloc] init] ;
        signatureElement.nsUri = AuthHeaderNS;
        signatureElement.name = @"Signature";
        signatureElement.value = signature;
      [customSoapHeaders addObject:signatureElement];
      
        // get shared client
        AWSECommerceServiceClient *client = [AWSECommerceServiceClient sharedClient];
        client.debug = YES;
        
        // build request, see details here:
        ItemSearch *request = [[[ItemSearch alloc] init] autorelease];
        request.associateTag = @"tag"; // seems any tag is ok
        request.shared = [[[ItemSearchRequest alloc] init] autorelease];
        request.shared.searchIndex = @"Books";
        request.shared.responseGroup = [NSMutableArray arrayWithObjects:@"Images", @"Small", nil];
        ItemSearchRequest *itemSearchRequest = [[[ItemSearchRequest alloc] init] autorelease];
        itemSearchRequest.title = _searchText.text;
        request.request = [NSMutableArray arrayWithObject:itemSearchRequest];
        
        // authenticate the request
        // http://docs.aws.amazon.com/AWSECommerceService/latest/DG/NotUsingWSSecurity.html
        [client authenticateRequest:@"ItemSearch"];
        [client itemSearch:request success:^(ItemSearchResponse *responseObject) {
            // stop progress activity
            [self.view hideToastActivity];
            
            // success handling logic
            if (responseObject.items.count > 0) {
                Items *items = [responseObject.items objectAtIndex:0];
                if (items.item.count > 0) {
                    Item *item = [items.item objectAtIndex:0];
                    
                    // start image downloading progress activity
                    [self.view makeToastActivity];
                    // get gallery image
                    NSURL *imageURL = [NSURL URLWithString:item.smallImage.url];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    // stop progress activity
                    [self.view hideToastActivity];
                    
                    UIImage *image = [UIImage imageWithData:imageData];
                    [self.view makeToast:item.itemAttributes.title duration:3.0 position:@"center" title:@"Success" image:image];
                } else {
                    // no result
                    [self.view makeToast:@"No result" duration:3.0 position:@"center"];
                }
                
            } else {
                // no result
                [self.view makeToast:@"No result" duration:3.0 position:@"center"];
            }
        } failure:^(NSError *error, id<PicoBindable> soapFault) {
            // stop progress activity
            [self.view hideToastActivity];
            
            // error handling logic
            if (error) { // http or parsing error
                [self.view makeToast:[error localizedDescription] duration:3.0 position:@"center" title:@"Error"];
            } else if (soapFault) {
                SOAP11Fault *soap11Fault = (SOAP11Fault *)soapFault;
                [self.view makeToast:soap11Fault.faultstring duration:3.0 position:@"center" title:@"SOAP Fault"];
            }
        }];
        
        
        
    
        NSLog(@"ApplePrices:%@",applePrices);
        NSLog(@"GooglePrices:%@", googleRetailPrices);
    
//Images(Big) extraction(Not Required)

//        if ([tempdd objectForKey: @"thumbnail"]!=0) {
//            [imageTemp addObject:[tempdd objectForKey:@"thumbnail"]];
//            NSString *imageStringSmall = imageTemp[i];
//            NSURL *imageURLSmall = [NSURL URLWithString:imageStringSmall];
//            NSData *imageDataSmall = [NSData dataWithContentsOfURL:imageURLSmall];
//            UIImage *imageSmall = [UIImage imageWithData:imageDataSmall];
//            [images addObject:imageSmall];
//            }
//        else {
//            [images addObject:imagena1];
//            }
        
        }
    
 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
 // NSLog(@"Author Array:%@",googleRetailPrices);
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
    return titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.bookTitle.text = titleArray[indexPath.row];
    
    NSString *cellPubText = [[NSString alloc]initWithFormat:@"Publisher: "];
    cellPubText = [cellPubText stringByAppendingString:publisherArray[indexPath.row]];
    cell.publisherBook.text = cellPubText;
    
    cell.bookImage.image = imageThumbnails[indexPath.row];
    
    NSString *cellAuthText = [[NSString alloc]initWithFormat:@"Authors: "];
    cellAuthText = [cellAuthText stringByAppendingString: authorsArray[indexPath.row]];
    cell.bookAuthors.text = cellAuthText;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"basicSearchSegue" sender:indexPath];
//}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    bookViewController *bvc = [segue destinationViewController];
    bvc.Image=[imageThumbnails objectAtIndex:indexPath.row] ;
    bvc.Title=[self.titleArray objectAtIndex:indexPath.row];
    NSString *descTemp =[self.descriptionArray objectAtIndex:indexPath.row];
    bvc.Description= [descTemp stripHtml];
    bvc.Publisher=[publisherArray objectAtIndex:indexPath.row];
    bvc.Author = [authorsArray objectAtIndex:indexPath.row];
}


@end
