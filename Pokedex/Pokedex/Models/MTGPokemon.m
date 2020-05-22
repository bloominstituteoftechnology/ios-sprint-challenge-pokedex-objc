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

    _name = dictionary[@"name"];
    NSString *detailURLString = dictionary[@"url"];

    _detailURL = [NSURL URLWithString:detailURLString];

//    if (_name == nil || _detailURL = nil) { return nil; }

    return self;
}

@end
