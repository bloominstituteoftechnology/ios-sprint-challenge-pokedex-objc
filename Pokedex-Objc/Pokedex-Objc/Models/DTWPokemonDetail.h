//
//  DTWPokemonDetail.h
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(PokemonDetail)
@interface DTWPokemonDetail : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSNumber *identifier;
@property (nonatomic, readonly, nullable) NSURL *spriteURL;
@property (nonatomic, copy, readonly, nonnull) NSString *abilities;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                          identifier:(nonnull NSNumber *)identifier
                           spriteURL:(nullable NSURL *)spriteURL
                           abilities:(nonnull NSString *)abilities;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

