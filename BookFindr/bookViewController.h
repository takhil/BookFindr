//
//  bookViewController.h
//  BookFindr
//
//  Created by Sresty Theegela on 1/17/16.
//  Copyright © 2016 AppBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UIView *bookAuthor;
@property (weak, nonatomic) IBOutlet UITextView *bookDescription;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisher;


//TabResTableViewController properties
@property (strong, nonatomic) NSString * Title;
@property (strong, nonatomic) NSString *Author;
@property (strong, nonatomic) NSString *Description;
@property (strong, nonatomic) NSString *Publisher;
@property (strong, nonatomic) UIImage *Image;
@end
