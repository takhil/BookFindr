//
//  customTableViewCell.h
//  BookFindr
//
//  Created by Sresty Theegela on 1/19/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthors;
@property (weak, nonatomic) IBOutlet UIImageView *googleBook;
@property (weak, nonatomic) IBOutlet UIImageView *appleBook;
@property (weak, nonatomic) IBOutlet UIImageView *amazonBook;
@property (weak, nonatomic) IBOutlet UILabel *publisherBook;

@end
