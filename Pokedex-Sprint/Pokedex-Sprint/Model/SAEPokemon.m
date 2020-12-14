//
//  SAEPokemon.m
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

#import "SAEPokemon.h"

@implementation SAEPokemon

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = dictionary [@"name"];
        NSString *urlString = dictionary[@"pokemonURL"];
        _pokemonURL = [[NSURL alloc] initWithString:urlString];
    }
    return self;
}

@end
