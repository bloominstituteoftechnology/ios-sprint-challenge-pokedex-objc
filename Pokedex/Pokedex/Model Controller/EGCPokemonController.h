//
//  EGCPokemonController.h
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGCPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface EGCPokemonController : NSObject

@property (nonatomic) EGCPokemon *pokemon;

- (instancetype)init;
- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<EGCPokemon *> * _Nullable pokemons, NSError * _Nullable error))completion;
- (void)fillInDetails:(EGCPokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
