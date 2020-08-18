//
//  JMCPokemon.h
//  Pokedex Objc C
//
//  Created by Jarren Campos on 8/14/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JMCPokemon : NSObject

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic) int id;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, copy, nullable) NSString *url;
@property (nonatomic, copy, nullable) NSArray *type;

- (nonnull instancetype)initWithName:(nullable NSString *)name
                              sprite:(nullable NSString *)sprite
                                 url:(nullable NSString *)url
                                  id:(int)id
                           abilities:(nullable NSArray *)abilities
                                type:(nullable NSArray *)types;


- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

