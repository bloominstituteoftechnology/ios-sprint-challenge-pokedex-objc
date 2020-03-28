//
//  CDBPokemon.h
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDBPokemonAbility;
@class CDBPokemonSprite;

NS_ASSUME_NONNULL_BEGIN

@interface CDBPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *url;
@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, strong, readonly, nullable) CDBPokemonSprite *sprite;
@property (nonatomic, copy, readonly, nullable) NSArray<CDBPokemonAbility *> *abilities;

- (instancetype) initWithName:(NSString *)name
                      withURL:(NSString *)url
               withIdentifier:(NSNumber *)identifier
               abilities:(nullable NSArray<CDBPokemonAbility *> *)abilities
               sprite:(nullable CDBPokemonSprite *)sprite;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

- (void)valuesFromDict:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
