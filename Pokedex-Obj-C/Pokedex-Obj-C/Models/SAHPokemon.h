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

@property (nonatomic) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic) NSData *imageData;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
