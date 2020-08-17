//
//  KRHPokemon.h
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KRHPokemonAbilities;


NS_ASSUME_NONNULL_BEGIN

@interface KRHPokemon : NSObject

@property (nonatomic,readonly, copy) NSString *name;
@property NSNumber *identifier;
@property NSURL *image;
@property NSArray<NSString *> *abilitiesArray;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSNumber *)identifier
                     sprite:(NSURL *)sprite
             abilitiesArray:(NSArray<NSString *> *)abilitiesArray;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
