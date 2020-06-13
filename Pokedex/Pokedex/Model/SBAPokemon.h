//
//  SBAPokemon.h
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//
//Your model must support at least: pokemon name, identifier, sprite, and abilities.
//For abilities, only the name of each ability is needed.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBAPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int *identifier;
@property (nonatomic, copy) NSURL *spriteURL;
@property (nonatomic) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
