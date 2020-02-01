//
//  SKSPokemonController.h
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSPokemon;

@interface SKSPokemonController : NSObject

- (void)fetchPokemonWithPokemonAPI:(void (^)(NSError *error))completion;

- (void)fetchDetailsWithPokemonAPIForPokemon:(SKSPokemon *)pokemon;

- (NSArray <SKSPokemon *> *)getPokemons;

@end

