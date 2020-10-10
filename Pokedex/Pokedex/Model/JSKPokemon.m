//
//  JSKPokemon.m
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

#import "JSKPokemon.h"

@implementation JSKPokemon

- (instancetype)initWIthName:(NSString *)name pokemonID:(int)pokemonID abilities:(NSArray *)abilities sprite:(nonnull NSString *)sprite
{
    if (self = [super init]) {
        _name = name;
        _abilities = abilities;
        _pokemonID = pokemonID;
        _sprite = sprite;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    int pokemonID = [dictionary[@"id"] intValue];
    NSString *name = dictionary[@"name"];
    NSArray *abilities = dictionary[@"abilities"];
    NSString *sprite = dictionary[@"sprties"][@"front_default"];
    NSMutableArray<NSString *> *abilityName = [[NSMutableArray alloc] init];
    for (NSDictionary *ability in abilities) {
        NSString *name = ability[@"ability"][@"name"];
        [abilityName addObject:name];
    }
    return [self initWIthName:name pokemonID:pokemonID abilities:abilityName sprite:sprite];
}
@end
