//
//  JDBPokemonAPI.h
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDBPokemon;

typedef void(^PokemonCompletionHandler)(JDBPokemon *pokemon, NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface JDBPokemonAPI : NSObject

- (void)fetchPokemon:(PokemonCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
