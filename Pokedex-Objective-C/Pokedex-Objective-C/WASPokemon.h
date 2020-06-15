//
//  WASPokemon.h
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WASPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic, copy, nullable) NSString *abilities;
@property (nonatomic, copy, nullable) NSURL *frontImage;

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                   abilities:(NSString *)abilities
                  frontImage:(NSURL *)frontImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
