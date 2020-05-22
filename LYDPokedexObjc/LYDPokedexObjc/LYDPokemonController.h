//
//  LYDPokemonController.h
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDPokemon.h"


@interface LYDPokemonController : NSObject

@property (nonatomic, nonnull) NSArray<LYDPokemon *> *pokeArray;

- (void)addPoke:(NSArray<LYDPokemon *> *_Nonnull)pokemon;

@end


