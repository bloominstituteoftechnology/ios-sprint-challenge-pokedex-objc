//
//  PokemonResults.h
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PokemonResults)

@interface PokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<Pokemon *> *pokemonArray;

- (instancetype)initWithPokemonArray:(NSArray<Pokemon *> *)pokemonArray;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
