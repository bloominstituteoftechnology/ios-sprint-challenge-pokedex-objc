//
//  MKMPokemon.h
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPokemon : NSObject

@property (nonatomic, nullable, readonly, copy) NSString *name;
@property (nonatomic, readonly) int identifier;
@property (nonatomic, nullable, readonly, copy) NSString *url;

@property (nonatomic, nullable) NSArray *abilities;
@property (nonatomic, nullable, readonly, copy) NSString *sprites;

- (instancetype) initWithName:(nullable NSString *)name
                   identifier:(int) identifier
                          url:(nullable NSString *) url
                    abilities:(nullable NSArray *) abilities
                      sprites:(nullable NSString *) sprites;

- (instancetype) initWithDictionary:(nullable NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
