//
//  JLRPokemon.m
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRPokemon.h"

@implementation JLRPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _pokemonName = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        _url = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
