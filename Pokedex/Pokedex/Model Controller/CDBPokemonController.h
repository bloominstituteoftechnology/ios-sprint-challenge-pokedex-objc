//
//  CDBPokemonController.h
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CDBPokemon;

@interface CDBPokemonController : NSObject

@property (nonatomic, copy, readonly) NSArray<CDBPokemon *> *pokemons;

@end

NS_ASSUME_NONNULL_END
