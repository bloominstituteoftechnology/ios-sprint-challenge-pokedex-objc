//
//  JDKPokemon.m
//  PokedexHybrid
//
//  Created by John Kouris on 2/22/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import "JDKPokemon.h"

@implementation JDKPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _pokemonName = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        _url = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
