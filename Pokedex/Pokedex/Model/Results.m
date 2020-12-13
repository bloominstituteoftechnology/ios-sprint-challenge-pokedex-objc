//
//  Results.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "Results.h"
#import "Pokemon.h"

@implementation Results

- (instancetype)initWithArray:(NSArray<Pokemon *> *)anArray
{
    if (self = [super init]) {
        _pokemonResults = anArray;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSArray *results = [aDictionary objectForKey:@"results"];
    NSMutableArray<Pokemon *> *pokemonArray = [[NSMutableArray<Pokemon *> alloc] init];

    for (NSMutableDictionary *pokemonDict in results) {
        NSString *name = [pokemonDict objectForKey:@"name"];
        Pokemon *pokemon = [[Pokemon alloc] initWithName:name];
        [pokemonArray addObject:pokemon];
    }
        
    return [self initWithArray:pokemonArray];
}

@end
