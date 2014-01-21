//
//  MovieDetailViewController.h
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterView;
@property (weak, nonatomic) IBOutlet UITableView *movieAboutView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (strong, nonatomic) Movie* movie;

@end
