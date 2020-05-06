//
//  MasterViewController.m
//  HeaderScroll
//
//  Created by Michael Nachbaur on 5/4/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "HeaderView.h"

@interface MasterViewController ()

@property (nonatomic, strong) HeaderView *headerView;

@end

@implementation MasterViewController

- (HeaderView *)headerView {
    if (_headerView == nil) {
        UINib *nib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
        _headerView = [nib instantiateWithOwner:self options:nil].firstObject;
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleHeight);
    self.headerView.titleLabel.text = nil;// @"Building a stretching UITableView header";
    self.headerView.scrollView = self.tableView;
    self.headerView.frame = CGRectMake(0,
                                       self.tableView.safeAreaInsets.top,
                                       CGRectGetWidth(self.tableView.frame),
                                       250);

    self.tableView.backgroundView = UIView.new;
    [self.tableView.backgroundView addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];

    self.tableView.contentInset = UIEdgeInsetsMake(250 + self.tableView.safeAreaInsets.top, 0, 0, 0);
    [self.headerView updatePosition];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.headerView updatePosition];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView updatePosition];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    return cell;
}

@end
