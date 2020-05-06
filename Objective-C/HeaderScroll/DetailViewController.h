//
//  DetailViewController.h
//  HeaderScroll
//
//  Created by Michael Nachbaur on 5/4/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

