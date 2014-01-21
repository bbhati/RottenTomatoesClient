//
//  MovieDetailViewController.m
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailCell.h"


@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.movieTitleLabel.text = self.movie.title;
    [self.moviePosterView setImageWithURL:[NSURL URLWithString:[self.movie imageDetailed]]];
    self.movieAboutView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.65];
    self.movieAboutView.delegate = self;
    self.movieAboutView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieDetailCell";
    MovieDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.row == 0) {
        cell.heading.text = @"Synopsis";
        
        cell.content.text = self.movie.synopsis;
    }
    else if (indexPath.row == 1){
        cell.heading.text = @"Cast";
        cell.content.text = self.movie.formatCast;
    }
    [cell.content sizeToFit];
    return cell;
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"In willDisplayCell");
//    //adjust row size
//    if(indexPath.row == 0) {
////        cell.heading.text = @"Synopsis";
////        cell.content.text = self.movie.title;
//    }
//    else if (indexPath.row == 1){
////        cell.heading.text = @"Cast";
////        cell.content.text = self.movie.formatCast;
//    }
//}


@end
