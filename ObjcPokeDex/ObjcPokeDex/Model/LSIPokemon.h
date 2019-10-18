//
//  LSIPokemon.h
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemon : NSObject

@property (nullable) NSNumber *ID;
@property (nonnull) NSString *name;
@property (nonnull) NSString *pokeInfoURL;
@property (nullable) NSMutableArray<NSString *> *abilites;
@property (nullable) NSString *spriteURLString;
-(instancetype)initDictionaryToGetNameAndURL:(nullable NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
