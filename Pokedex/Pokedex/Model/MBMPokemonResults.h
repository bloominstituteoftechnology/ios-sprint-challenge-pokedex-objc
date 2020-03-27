//
//  MBMPokemonResults.h
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBMPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface MBMPokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<MBMPokemon *> *pokemon;

- (instancetype)initWithPokemon:(NSArray<MBMPokemon *> *)pokemon;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
