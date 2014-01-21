//
//  Movie.m
//  TomatoClient
//
//  Created by Chix on 1/18/14.
//  Copyright (c) 2014 Bhagyashree. All rights reserved.
//

#import "Movie.h"
@interface Movie()

@end

@implementation Movie
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if(self = [super init]) {
        self.title = [dictionary objectForKey:@"title"];
        self.synopsis = [dictionary objectForKey:@"synopsis"];
        self.cast = [dictionary objectForKey:@"abridged_cast"];
        self.posters = [dictionary objectForKey:@"posters"];
        return self;
    }
    return nil;
}

-(NSString*)formatCast{
    NSMutableArray* castMembers = [[NSMutableArray alloc] initWithCapacity:5];
    NSString* castString;
    if(self.cast){
        for(NSDictionary* castObj in self.cast){
            [castMembers addObject:[castObj objectForKey:@"name"]];
        }
        castString = [castMembers componentsJoinedByString:@", "];
    }
    return castString;
}

-(NSString*)imageThumbnail{
    if(self.posters){
        return [self.posters objectForKey:@"thumbnail"];
    }
    return nil;
}

-(NSString*) imageDetailed{
    if(self.posters){
        return [self.posters objectForKey:@"detailed"];
    }
    return nil;
}

@end
