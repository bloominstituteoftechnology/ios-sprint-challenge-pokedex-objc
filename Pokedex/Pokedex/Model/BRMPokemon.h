//
//  BRMPokemon.h
//  Pokedex
//
//  Created by Bronson Mullens on 10/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRMPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic, copy, nullable) NSURL *sprite;
@property (nonatomic, copy, readonly, nullable) NSString *abilities;
@property (nonatomic, nullable) NSURL *pokemonURL;

- (nonnull instancetype)initWithName:(nonnull NSString *)aName
                          identifier:(int)anIdentifier
                              sprite:(nullable NSURL *)aSprite
                           abilities:(nullable NSString *)theAbilities
                          pokemonURL:(nullable NSURL *)aPokemonURL;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
