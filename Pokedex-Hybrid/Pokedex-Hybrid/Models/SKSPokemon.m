//
//  SKSPokemon.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokemon.h"

@interface SKSPokemon()



@end

@implementation SKSPokemon


- (instancetype _Nonnull)initWithDictionary:(nonnull NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _detailsURL = [NSURL URLWithString:dictionary[@"url"]];
    }
    return self;
}

- (void)pokemonDetailsWithDictionary:(nonnull NSDictionary *)dictionary {
    NSArray *abilitiesDictionaries = dictionary[@"abilities"];

    for (NSDictionary *abilityDictionary in abilitiesDictionaries) {
        NSDictionary *ability = abilityDictionary[@"ability"];
        NSLog(@"Ability name: %@", ability[@"name"]);
        [self.abilities addObject:ability[@"name"]];
    }
    self.pokemonId = [dictionary[@"id"] intValue];
}

@end
