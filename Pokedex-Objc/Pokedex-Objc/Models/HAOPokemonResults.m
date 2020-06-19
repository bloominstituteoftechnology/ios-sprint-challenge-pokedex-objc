//
//  HAOPokemonResults.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemonResults.h"
#import "HAOPokemon.h"

@implementation HAOPokemonResults

- (instancetype)initWithPokemonArray:(NSArray<HAOPokemon *> *)pokemonArray
{
    self = [super init];
    if (self) {
        _pokemonArray = [pokemonArray copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSArray *results = dictionary[@"results"];
    NSMutableArray *pokemonArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *pokemonDictionary in results) {
        NSString *name = pokemonDictionary[@"name"];
        HAOPokemon *pokemon = [[HAOPokemon alloc] initWithName:name];
        if(pokemon) {
            [pokemonArray addObject:pokemon];
        } else {
            NSLog(@"Unable to get name for pokemon from dictionary: %@", pokemonDictionary);
        }
    }
    
    self = [self initWithPokemonArray:pokemonArray];
    return self;
}

@end
