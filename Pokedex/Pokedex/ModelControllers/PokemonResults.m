//
//  PokemonResults.m
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import "PokemonResults.h"
#import "Pokemon.h"

@implementation PokemonResults

- (instancetype)initWithPokemonArray:(NSArray<Pokemon *> *)pokemonArray count:(NSNumber *)count next:(NSString *)next
{
    if (self = [super init]) {
        _pokemonArray = pokemonArray;
        _count = count;
        _next = next;
    }
    return self;
}

- (instancetype)initFromData:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (!dictionary) {
        NSLog(@"Error decoding JSON: %@", jsonError);
    }

    NSNumber *count = dictionary[@"count"];
    if (![count isKindOfClass:NSNumber.class]) return nil;

    NSString *next = dictionary[@"next"];
    if (![next isKindOfClass:NSString.class]) return nil;

    NSArray *results = dictionary[@"results"];
    if (![results isKindOfClass:NSArray.class]) return nil;

    NSMutableArray *pokemonArray = [[NSMutableArray alloc] initWithCapacity:results.count];

    for (NSDictionary *pokemonDictionary in results) {
        if (![pokemonDictionary isKindOfClass:NSDictionary.class]) continue;

        Pokemon *pokemon = [[Pokemon alloc] initFromDictionary:pokemonDictionary];
        if (pokemon) {
            [pokemonArray addObject:pokemon];
        } else {
            NSLog(@"Unable to parse pokemon dictionary: %@", pokemonDictionary);
        }
    }

    return [self initWithPokemonArray:pokemonArray count:count next:next];
}

@end
