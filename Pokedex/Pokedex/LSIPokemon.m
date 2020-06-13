//
//  LSIPokemon.m
//  Pokedex
//
//  Created by Enayatullah Naseri on 6/12/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

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
