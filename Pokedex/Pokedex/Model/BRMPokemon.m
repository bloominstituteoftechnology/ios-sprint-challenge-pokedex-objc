//
//  BRMPokemon.m
//  Pokedex
//
//  Created by Bronson Mullens on 10/9/20.
//

#import "BRMPokemon.h"

@implementation BRMPokemon

- (nonnull instancetype)initWithName:(NSString *)aName
                          identifier:(int)anIdentifier
                              sprite:(NSURL *)aSprite
                           abilities:(NSString *)theAbilities
                          pokemonURL:(NSURL *)aPokemonURL {
    self = [super init];
    if (self) {
        _name = aName;
        _identifier = anIdentifier;
        _sprite = aSprite;
        _abilities = theAbilities;
        _pokemonURL = aPokemonURL;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    int identifier = [dictionary[@"id"] intValue];
    
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    if (![spriteString isKindOfClass:[NSString class]]) {
        spriteString = @"";
    }
    NSURL *sprite = [NSURL URLWithString:spriteString];
    
    NSString *abilities = @"";
    NSArray *abilityDictionaries = dictionary[@"abilities"];
    for (NSDictionary *abilityDictionary in abilityDictionaries) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        abilities = [abilities stringByAppendingString:[NSString stringWithFormat:@"%@\n", ability]];
    }
    
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [self initWithName:name
                   identifier:identifier
                       sprite:sprite
                    abilities:abilities
                   pokemonURL:url];
}

@end
