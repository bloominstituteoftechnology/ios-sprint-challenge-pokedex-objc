//
//  PokemonResults.m
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import "PokemonResults.h"
#import "BTPokemon.h"

@implementation PokemonResults

- (instancetype)initWithPokemonName:(NSArray<BTPokemon *> *)pokemonName {
    
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
        BTPokemon *pokemon = [[BTPokemon alloc] initWithDictionary:pokemonDictionary];
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
