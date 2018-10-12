//
//  JTMPokemon.h
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTMPokemon : NSObject

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier
                      sprite:(NSData *)sprite
                   abilities:(NSArray<NSString *> *)abilities;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *identifier;
@property (nonatomic, copy, readonly, nullable) NSData *sprite;
@property (nonatomic, copy, readonly, nullable) NSArray<NSString *> *abilities;

@end

NS_ASSUME_NONNULL_END
