//
//  PokemonResults.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "PokemonResults.h"
#import "Pokemon.h"

@implementation PokemonResults

- (instancetype)initWithPokemonArray:(NSArray<Pokemon *> *)pokemonArray
{
    self = [super init];
    
    if(self)
    {
        _pokemonArray = [pokemonArray copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSArray *results = dictionary[@"results"];
    NSMutableArray *pokemonArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *pokemonDictionary in results)
    {
        NSString *name = pokemonDictionary[@"name"];
        Pokemon *pokemon = [[Pokemon alloc] initWithName:name];
        if(pokemon)
        {
            [pokemonArray addObject:pokemon];
        } else {
            NSLog(@"Unable to get pokemon from dictionary: %@", pokemonDictionary);
        }
    }
    
    self = [self initWithPokemonArray:pokemonArray];
    return self;
}

@end
