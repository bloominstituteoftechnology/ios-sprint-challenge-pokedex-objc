//
//  MBMPokemonResults.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMPokemonResults.h"
#import "MBMPokemon.h"


@implementation MBMPokemonResults

- (instancetype)initWithPokemon:(NSArray<MBMPokemon *> *)pokemon {
    self = [super init];
    if (self) {
        _pokemon = [pokemon copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSArray *pokemonDictionaries = dictionary[@"results"];
    
    NSMutableArray<MBMPokemon *> *pokemon = [[NSMutableArray alloc] init];
    
    for (NSDictionary *aPokemonDict in pokemonDictionaries) {
        MBMPokemon *aPokemon = [[MBMPokemon alloc] initWithDictionary:aPokemonDict];
        
        if (aPokemon) {
            [pokemon addObject:aPokemon];
        } else {
            NSLog(@"Unable to parse pokemon dictionary: %@", aPokemonDict);
        }
    }
    self = [self initWithPokemon:pokemon];
    return self;
}

@end
