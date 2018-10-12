//
//  Pokemon.m
//  Pokedex
//
//  Created by Andrew Liao on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

#import "AELPokemon.h"

@implementation AELPokemon

-(instancetype) initWithName: (NSString *) name url: (NSString *) url
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"dictionary"];
    return [self initWithName:name url:url];
}


@end
