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

@property (nonatomic) VVSPokemon *pokemon;

- (instancetype)init;

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<VVSPokemon *> * _Nullable pokemons, NSError * _Nullable error))completion;

- (void)fillInDetails:(VVSPokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
