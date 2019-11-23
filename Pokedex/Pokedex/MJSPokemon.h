//
//  MJSPokemon.h
//  Pokedex
//
//  Created by Michael Stoffer on 11/23/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJSPokemon : NSObject

@property (nonatomic) int id;
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *url;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, copy, nullable) NSString *sprites;

- (nonnull instancetype)initWithName:(nullable NSString *)name
                                 url:(nullable NSString *)url
                                  id:(int)id
                           abilities:(nullable NSArray *)abilities
                             sprites:(nullable NSString *)sprites;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
