//
//  PokemonResults.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/24/21.
//

#import "PokemonResults.h"
#import "Pokemon.h"

@implementation PokemonResults

- (instancetype)initWithArray:(NSArray<Pokemon *> *)anArray
{
    if (self = [super init]) {
        _pokemonResults = anArray;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSArray *dictionaryResults = [aDictionary objectForKey:@"results"];
    NSMutableArray<Pokemon *> *pokemonArray = [[NSMutableArray<Pokemon *> alloc] init];

    for (NSMutableDictionary *pokemonDictionary in dictionaryResults) {
        Pokemon *pokemon = [[Pokemon alloc] initWithDictionary:pokemonDictionary];
        [pokemonArray addObject:pokemon];
    }
        
    return [self initWithArray:pokemonArray];
}

@end
