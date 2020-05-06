//
//  HeaderView.h
//  HeaderScroll
//
//  Created by Michael Nachbaur on 5/4/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (nullable, weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)updatePosition;

@end

NS_ASSUME_NONNULL_END
