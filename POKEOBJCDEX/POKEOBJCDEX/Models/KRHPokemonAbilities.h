//
//  KRHPokemonAbilities.h
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRHPokemonAbilities : NSObject

@property (nonatomic, readonly, copy) NSString *name;

-(instancetype)initWithName:(NSString *)name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
