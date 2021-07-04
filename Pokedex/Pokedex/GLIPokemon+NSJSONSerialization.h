//
//  GLIPokemon+NSJSONSerialization.h
//  Pokedex
//
//  Created by Julian A. Fordyce on 4/12/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

#import "GLIPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface GLIPokemon (NSJSONSerialization)

 - (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
