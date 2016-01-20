//
//  tabResTableViewController.h
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface tabResTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *selfLinksArray;
@property (strong, nonatomic) NSMutableArray *selfLinksArrayURL;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *authorsArray;
@end
