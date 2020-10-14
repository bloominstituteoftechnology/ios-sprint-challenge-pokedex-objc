//
//  PokemonResults.h
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import <Foundation/Foundation.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PokemonResults)

@interface PokemonResults : NSObject

@property (nonatomic) NSNumber *count;
@property (nonatomic, copy) NSString *next;
@property (nonatomic, copy) NSArray<Pokemon *> *pokemonArray;

- (instancetype)initWithPokemonArray:(NSArray<Pokemon *> *)pokemonArray count:(NSNumber *)count next:(NSString *)next;
- (nullable instancetype)initFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
