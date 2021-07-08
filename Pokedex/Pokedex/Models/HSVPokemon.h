//
//  HSVPokemon.h
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Pokemon)
NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemon : NSObject


@property (nonatomic, nullable, copy) NSString *name;
@property (nonatomic, nullable, copy) NSString *identifier;

@property (nonatomic, nullable, readwrite, copy) NSString *sprite;
@property (nonatomic, nullable, readwrite, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
