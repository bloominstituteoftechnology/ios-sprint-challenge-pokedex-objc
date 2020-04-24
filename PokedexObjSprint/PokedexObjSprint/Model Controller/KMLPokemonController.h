//
//  KMLPokemonController.h
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMLPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface KMLPokemonController : NSObject

@property (nonatomic) KMLPokemon *pokemon;

- (instancetype)init;

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<KMLPokemon *> * _Nullable pokemons, NSError * _Nullable error))completion;

- (void)fillInDetails:(KMLPokemon *)pokemon;


@end

NS_ASSUME_NONNULL_END
