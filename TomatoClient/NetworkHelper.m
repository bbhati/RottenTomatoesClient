//
//  NetworkHelper.m
//  TomatoClient
//
//  Created by Chix on 1/19/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper


+(void) checkInternet:(NSString*)url
{
    Reachability* reach = [Reachability reachabilityWithHostname:url];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        NSLog(@"REACHABLE!");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Network working!");
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
            
        });
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}

@end
