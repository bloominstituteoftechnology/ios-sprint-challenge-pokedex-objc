//
//  SMAPokemon.h
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMAPokemon : NSObject

- (instancetype)initWithName:(NSString *)name
                  identifier:(nullable NSString *)identifier
                   abilities:(nullable NSArray *)abilities
                   urlString:(nullable NSString *)urlString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property(nonatomic, readonly, copy) NSString *name;
@property(nonatomic, readonly, copy, nullable) NSString *identifier;
@property(nonatomic, readonly, nullable) NSArray<NSString *> *abilities;
@property(nonatomic, readonly, copy, nullable) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
