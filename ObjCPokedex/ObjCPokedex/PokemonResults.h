//
//  PokemonResults.h
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/24/21.
//

#import <Foundation/Foundation.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonResults : NSObject

@property NSArray<Pokemon *> *pokemonResults;

- (instancetype)initWithArray:(NSArray<Pokemon *> *)anArray;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
