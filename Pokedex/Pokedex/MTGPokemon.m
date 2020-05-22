//
//  MTGPokemon.m
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import "MTGPokemon.h"

@implementation MTGPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (!self) { return nil; }

    _name = dictionary[@"title"];
    _identifier = dictionary[@"alt"];
    NSString *imageURLString = dictionary[@"img"];
    _abilities = dictionary[@"alt"];

    _imageURL = [NSURL URLWithString:imageURLString];

    return self;
}

@end
