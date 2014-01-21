//
//  Movie.h
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString* title;
@property NSString* synopsis;
@property NSArray* cast;
@property NSDictionary* posters;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(NSString*)formatCast;
-(NSString*)imageThumbnail;
-(NSString*)imageDetailed;

@end
