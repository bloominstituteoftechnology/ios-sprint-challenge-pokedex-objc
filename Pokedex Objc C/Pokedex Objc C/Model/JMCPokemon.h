//
//  JMCPokemon.h
//  Pokedex Objc C
//
//  Created by Jarren Campos on 8/14/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCPokemon : NSObject

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic) int id;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, copy, nullable) NSString *url;

- (nonnull instancetype)initWithName:(nullable NSString *)name
                              sprite:(nullable NSString *)sprite
                                 url:(nullable NSString *)url
                                  id:(int)id
                           abilities:(nullable NSArray *)abilities;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
