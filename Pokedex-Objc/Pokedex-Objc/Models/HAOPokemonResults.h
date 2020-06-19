//
//  HAOPokemonResults.h
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HAOPokemon;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PokemonResults)

@interface HAOPokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<HAOPokemon *> *pokemonArray;

- (instancetype)initWithPokemonArray:(NSArray<HAOPokemon *> *)pokemonArray;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
