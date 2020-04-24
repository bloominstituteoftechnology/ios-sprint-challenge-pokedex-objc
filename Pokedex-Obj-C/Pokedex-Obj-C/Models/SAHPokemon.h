//
//  SAHPokemon.h
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAHPokemon : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSData *imageData;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

