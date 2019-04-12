//
//  FCCPokemon.h
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 4/12/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FCCPokemon : NSObject

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSArray *)abilities sprite:(NSURL *)sprite;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *identifier;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, copy, nullable) NSURL *sprite;

@end

@interface FCCPokemon (JSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
