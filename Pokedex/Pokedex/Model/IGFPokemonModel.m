//
//  IGFPokemonModel.m
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import "IGFPokemonModel.h"

@interface IGFPokemonModel()

@end


@implementation IGFPokemonModel


- (instancetype _Nonnull)initWithDictionary:(nonnull NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _detailsURL = [NSURL URLWithString:dictionary[@"url"]];
        _abilities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)pokemonDetailsWithDictionary:(nonnull NSDictionary *)dictionary
{
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSDictionary *ability = abilityDictionary[@"ability"];
        NSString *abilityName = ability[@"name"];
        [self.abilities addObject:abilityName];
    }
    
    self.pokemonId = [dictionary[@"id"] intValue];
    
    NSDictionary *spritesDictionary = dictionary[@"sprites"];
    NSURL *spriteURL = [NSURL URLWithString:spritesDictionary[@"front_default"]];
    NSData *imageData = [NSData dataWithContentsOfURL:spriteURL];
    self.pokemonSprite = [UIImage imageWithData:imageData];
}





@end
