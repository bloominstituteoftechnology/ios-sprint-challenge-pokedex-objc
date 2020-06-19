//
//  HAOPokemon.h
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAOPokemon : NSObject

@property NSString *name;
@property NSString *identifier;
@property NSArray<NSString *> *abilites;

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifer abilities:(NSArray<NSString *> *)abilites;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
