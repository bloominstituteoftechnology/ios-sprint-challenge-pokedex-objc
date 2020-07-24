//
//  CAMPokemon.h
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAMPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int number;
@property (nonatomic, readonly) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name
                      number:(int)number
                   abilities:(NSArray<NSString*>*)abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
