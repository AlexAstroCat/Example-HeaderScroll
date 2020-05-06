//
//  HeaderView.m
//  HeaderScroll
//
//  Created by Michael Nachbaur on 5/4/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (strong, nonatomic, readwrite) IBOutlet UIImageView *imageView;
@property (strong, nonatomic, readwrite) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (nonatomic, assign) CGSize cachedMinimumSize;
@property (nonatomic, assign) CGFloat minimumHeight;

@end

@implementation HeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.sizeLabel.text = [NSString stringWithFormat:@"%0.1fx%0.1f",
                           CGRectGetWidth(self.frame),
                           CGRectGetHeight(self.frame)];
}

// Calculate and cache the minimum size the header's constraints will fit.
// This value is cached since it can be a costly calculation to make, and
// we want to keep the framerate high.
- (CGFloat)minimumHeight {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return 0;
    }
    
    CGFloat width = CGRectGetWidth(scrollView.frame);
    if (!CGSizeEqualToSize(self.cachedMinimumSize, CGSizeZero)) {
        if (self.cachedMinimumSize.width == width) {
            return self.cachedMinimumSize.height;
        }
    }
    
    CGSize size = [self systemLayoutSizeFittingSize:CGSizeMake(width, 0)
                      withHorizontalFittingPriority:UILayoutPriorityRequired
                            verticalFittingPriority:UILayoutPriorityDefaultLow];
    self.cachedMinimumSize = size;
    return size.height;
}

- (void)updatePosition {
    UIScrollView *scrollView = self.scrollView;
    if (scrollView == nil) {
        return;
    }

    // Calculate the minimum size the header's constraints will fit
    CGFloat minimumSize = self.minimumHeight;
    
    // Calculate the baseline header height and vertical position
    CGFloat referenceOffset = scrollView.safeAreaInsets.top;
    CGFloat referenceHeight = scrollView.contentInset.top - referenceOffset;
    
    // Calculate the new frame size and position
    CGFloat offset = referenceHeight + scrollView.contentOffset.y;
    CGFloat targetHeight = referenceHeight - offset - referenceOffset;
    CGFloat targetOffset = referenceOffset;
    if (targetHeight < minimumSize) {
        targetOffset += targetHeight - minimumSize;
    }
    
    // Update the header's height and vertical position.
    CGRect headerFrame = self.frame;
    headerFrame.size.height = MAX(minimumSize, targetHeight);
    headerFrame.origin.y = targetOffset;
    
    self.frame = headerFrame;
}

@end
