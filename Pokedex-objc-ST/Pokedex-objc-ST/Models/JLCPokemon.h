//
//  JLCPokemon.h
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLCPokemon : NSObject

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
