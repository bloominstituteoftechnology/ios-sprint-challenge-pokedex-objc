//
//  MJRPokemon.h
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface MJRPokemon : NSObject

-(instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSArray *)abilities sprite:(NSURL *)sprite;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readwrite, nullable) NSNumber *identifier;
@property (nonatomic, copy, readwrite, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, copy, readwrite, nullable) NSURL *sprite;

@end

@interface MJRPokemon (JSONSerialization)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
