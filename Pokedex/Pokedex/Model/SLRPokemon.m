//
//  SLRPokemon.m
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRPokemon.h"

@implementation SLRPokemon


// Network results of Pokemon detail network call
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *pokemonName = dictionary[@"name"];
    NSString *detailLink = dictionary[@"url"];
    return [self initWithPokemonName:pokemonName detailLink:detailLink];
    
}


// Initialize the model and get list of Pokemon
- (instancetype) initWithPokemonName:(NSString *)pokemonName detailLink:(NSString *)detailLink {
    if (self = [super init]) {
        self.pokemonName = pokemonName;
        self.detailLink = detailLink;
    }
    return self;
}




@end
