//
//  VVSPokemon.h
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVSPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSURL *spriteURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
