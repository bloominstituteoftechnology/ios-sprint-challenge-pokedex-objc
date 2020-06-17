//
//  JAGPokemon.h
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)
@interface JAGPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic, readonly, copy) NSString *spriteURLString;
@property (nonatomic) NSArray <NSString *> *abilities;
@property (nonatomic, readonly, copy) NSString *pokemonURLasString;

- (instancetype)initWithName:(NSString *)name andURLString:(NSString *)pokemonURLString;

- (instancetype)initWithName:(NSString *)aName
               andIdentifier:(NSNumber *)anIdentifier
                  withSprite:(NSString *)aSpriteURLString
                andAbilities:(NSArray <NSString *> *)abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


NS_ASSUME_NONNULL_END
