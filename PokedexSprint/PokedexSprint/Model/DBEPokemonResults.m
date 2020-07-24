//
//  DBEPokemonResults.m
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

#import "DBEPokemonResults.h"
#import "DBEPokemon.h"

@implementation DBEPokemonResults

- (instancetype)initWithPokemonArray:(NSArray<DBEPokemon *> *)pokemonArray
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
        NSString *detailURL = pokemonDictionary[@"detailURL"];
        DBEPokemon *pokemon = [[DBEPokemon alloc] initWithName:name detailURL:detailURL];
        if (pokemon) {
            [pokemonArray addObject:pokemon];
        } else {
            NSLog(@"Unable to fetch pokemon from dictionary: %@", pokemonDictionary);
        }
    }
    
    self = [self initWithPokemonArray:pokemonArray];
    return self;
}

@end
