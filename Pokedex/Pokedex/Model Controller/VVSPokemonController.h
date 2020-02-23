//
//  VVSPokemonController.h
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVSPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVSPokemonController : NSObject

- (instancetype)init;

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<VVSPokemon *> * _Nullable pokemons, NSError * _Nullable error))completion;

- (void)fetchPokemonWithName:(NSString *)name
                  completion:(void (^)(VVSPokemon * _Nullable pokemon, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
