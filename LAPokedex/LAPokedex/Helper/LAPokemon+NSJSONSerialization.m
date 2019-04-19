//
//  LAPokemon+NSJSONSerialization.m
//  LAPokedex
//
//  Created by Angel Buenrostro on 4/15/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

#import "LAPokemon+NSJSONSerialization.h"
#import "LAPokemon.h"

@implementation LAPokemon (NSJSONSerialization)

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        self.name = name;
//        self.identifier = 0;
//        self.abilities = NULL;
//        self.sprites = NULL;
    }
    return self;
}

-(nonnull instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = [dictionary objectForKey:@"name"];
        self.identifier = [[dictionary objectForKey:@"id"] intValue];
        self.abilities = [dictionary objectForKey:@"abilities"];
        self.sprites = [dictionary objectForKey:@"sprites"];
    }
    return self;
}

@end
