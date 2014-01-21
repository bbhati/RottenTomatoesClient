//
//  MoviesViewController.m
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "Reachability.h"
#import "ErrorCell.h"
#import "MBProgressHUD.h"
#import "ATMHud.h"

@interface MoviesViewController ()
@property (nonatomic, strong) NSMutableArray* movies;
@property (nonatomic, strong) NSString* errorHeader;
@property (nonatomic) BOOL isNetworkError;
@property (nonatomic) BOOL isHoodLoaded;
@property (nonatomic, retain) NSMutableData *resourceData;
@property (nonatomic, retain) NSNumber *filesize;
@property (nonatomic, strong) ATMHud *hud;
-(void)setup;
-(void) reload;

@end

@implementation MoviesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.hud = [[MBProgressHUD alloc] initWithDelegate:self];
//        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
//        [self.navigationController.view addSubview:self.hud];
//        [self.hud setLabelText:@"Loading"];
        // Register for HUD callbacks so we can remove it from the window at the right time
//        self.hud.delegate = self;
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(setup) forControlEvents:UIControlEventValueChanged];
 
    self.refreshControl = refresh;
    
   
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.movies count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"SectionHeader";
    ErrorCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(self.isNetworkError && headerView != nil){
        headerView.heading.text = @"Network Error";
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self.isNetworkError){
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Movie* movieObj = [self.movies objectAtIndex:[indexPath row]];
    cell.movieTitle.text = movieObj.title;
    cell.synopsis.text = movieObj.synopsis;
    cell.cast.text = movieObj.formatCast;

    //Set image async
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:movieObj.imageThumbnail]];

    return cell;
}



#pragma mark - Table view delegate


-(void) setup {
    self.movies = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self reload];
    
}

- (void)backgroundDone {
    NSLog(@"Done");
    [self.hud hide];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
}

-(void)reload{

    [self checkInternet:@"api.rottentomatoes.com"];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";

    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    // Show the HUD while the update method executes in a new thread
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSLog(@"Start");

//        if(!self.isHoodLoaded) {
//            self.hud = [[ATMHud alloc] initWithDelegate:self];
//            [self.tableView addSubview:self.hud.view];
//            [self.hud setActivity:YES];
//            [self.hud show];
//        }
//        self.isHoodLoaded = YES;
        for (int i = 0; i< 5; i++) {
            [NSThread sleepForTimeInterval:.05];
            NSLog(@"%i", i);
        }

         NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
         [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                self.filesize = [NSNumber numberWithLongLong:[response expectedContentLength]];
                
                if(data != nil){
                    NSDictionary* object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    NSArray* movies = [object objectForKey:@"movies"];
                    
                    for(NSDictionary* movie in movies){
                        [self.movies addObject:[[Movie alloc] initWithDictionary:movie]];
                    }
                }
                
                [self.tableView reloadData];
                [self stopRefresh];
                
                
            }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self backgroundDone];
        });
    });
    
    }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MovieDetailViewController *movieViewController = (MovieDetailViewController *)segue.destinationViewController;
    movieViewController.movie = movie;
}

- (void)stopRefresh

{
    [self.refreshControl endRefreshing];   
}

- (void) checkInternet:(NSString*)url
{
    Reachability* reach = [Reachability reachabilityWithHostname:url];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        NSLog(@"REACHABLE!");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Network working!");
            self.isNetworkError = NO;
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
        //Display error
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :(");
            //tableview reload
            self.errorHeader = @"Network error";
            self.isNetworkError = YES;
        });
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}

@end
