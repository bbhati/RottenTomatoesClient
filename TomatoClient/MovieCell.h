//
//  MovieCell.h
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* movieTitle;
@property (nonatomic, weak) IBOutlet UILabel* synopsis;
@property (nonatomic, weak) IBOutlet UILabel* cast;
@property (nonatomic, weak) IBOutlet UIImageView* thumbnail;

@end
