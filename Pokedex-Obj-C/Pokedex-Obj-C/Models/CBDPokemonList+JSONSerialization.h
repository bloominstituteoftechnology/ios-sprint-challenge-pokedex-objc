//
//  CBDPokemonList+JSONSerialization.h
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemonList.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBDPokemonList (JSONSerialization)

-(instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
