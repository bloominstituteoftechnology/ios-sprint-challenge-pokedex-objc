//
//  Pokemon.h
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property NSString *name;
@property NSString *identifier;
@property NSArray<NSString *> *abilites;

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifer abilities:(NSArray<NSString *> *)abilites;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
