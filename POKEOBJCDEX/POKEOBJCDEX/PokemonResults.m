//
//  PokemonResults.m
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "PokemonResults.h"
#import "KRHPokemon.h"

@implementation PokemonResults

- (instancetype)initWithPokemonName:(NSArray<KRHPokemon *> *)pokemonName {
    
    self = [super init];
    if (self) {
        _pokemon = pokemonName;
    }
    return self;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSArray *pokemonDictionaries = dictionary[@"results"];
    NSMutableArray *pokemonNames = [[NSMutableArray alloc]init];
    
    for (NSDictionary *pokemonDictionary in pokemonDictionaries) {
        KRHPokemon *pokemon = [[KRHPokemon alloc] initWithDictionary:pokemonDictionary];
        if (pokemon) {
            [pokemonNames addObject:pokemon];
        } else {
          NSLog(@"Unable to parse pokemonName dictionary: %@", pokemonDictionary);
        }
    }

    self = [self initWithPokemonName:pokemonNames];
    return self;
}

@end

