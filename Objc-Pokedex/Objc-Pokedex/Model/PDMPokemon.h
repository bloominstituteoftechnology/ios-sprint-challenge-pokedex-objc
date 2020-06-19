//
//  PDMPokemon.h
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDMPokemonSprite;
@class PDMPokemonAbility;

NS_ASSUME_NONNULL_BEGIN

@interface PDMPokemon : NSObject

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSInteger)identifier
                   abilities:(nullable NSArray<PDMPokemonAbility *> *)abilities
                      sprite:(nullable PDMPokemonSprite *)sprite;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)readFromDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly, nullable) NSArray<PDMPokemonAbility *> *abilities;
@property (nonatomic, strong, readonly, nullable) PDMPokemonSprite *sprite;

@property (nonatomic) BOOL haveCaught;

@end

NS_ASSUME_NONNULL_END
