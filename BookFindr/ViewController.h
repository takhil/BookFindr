//
//  ViewController.h
//  BookFindr
//
//  Created by Sresty Theegela on 1/16/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tabResTableViewController.h"
//#import "AFNetworking.h"
@interface ViewController : UIViewController
@property(strong,nonatomic) NSString *searchString;
@property (strong, nonatomic) NSMutableDictionary *dictSearch;
@property (strong, nonatomic) NSMutableArray *booksArray;
@property (strong, nonatomic) NSMutableArray *tempArray;
@end

