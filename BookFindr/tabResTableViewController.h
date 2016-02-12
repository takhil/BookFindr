//
//  tabResTableViewController.h
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "customTableViewCell.h"

@interface tabResTableViewController : UITableViewController

//Google Books API Properties
@property (strong, nonatomic) NSMutableArray *selfLinksArray;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *authorsArray;
@property (strong, nonatomic) NSMutableArray *publisherArray;
@property (strong, nonatomic) NSMutableArray *descriptionArray;
@property (strong, nonatomic) NSMutableArray *isbn13;
@property (strong, nonatomic) NSMutableArray *imageThumbnails;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *googleRating;
@property (strong, nonatomic) NSMutableArray *googleRatingsCount;
@property (strong, nonatomic) NSString *authorsString;
@property (strong, nonatomic) NSMutableDictionary *ISBN13;
@property (strong, nonatomic) NSMutableDictionary *saleInfoDict;


//Google Boooks Prices properties
@property (strong, nonatomic) NSMutableArray *googleListPrices;
@property (strong, nonatomic) NSMutableArray *googleRetailPrices;


//Apple Properties
@property (strong, nonatomic) NSString *UrlStringApple;
@property (strong, nonatomic) NSURL *UrlApple;
@property (strong, nonatomic) NSData *AppleData;
@property (strong, nonatomic) NSMutableDictionary *AppleDict;
@property (strong, nonatomic) NSMutableArray *applePrices;
@end
