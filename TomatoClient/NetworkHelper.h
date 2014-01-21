//
//  NetworkHelper.h
//  TomatoClient
//
//  Created by Chix on 1/19/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetworkHelper : NSObject

+(void) checkInternet:(NSString*)url;

@end
