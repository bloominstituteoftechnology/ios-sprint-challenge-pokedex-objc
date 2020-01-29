//
//  JLRPokemon.h
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface JLRPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *pokemonName;
@property (nonatomic, copy, nonnull) NSURL *url;
@property (nonatomic, copy) NSNumber *pokemonID;
@property (nonatomic, copy) NSString *pokemonAbilities;
@property (nonatomic, copy) NSData *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
