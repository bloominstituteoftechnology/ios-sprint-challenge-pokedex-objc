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
@property (nonatomic, nullable, readonly, copy) NSString *url;

- (instancetype) initWithName:(nullable NSString *) name
                          url:(nullable NSString *) url;

- (instancetype) initWithDictionary:(nullable NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
