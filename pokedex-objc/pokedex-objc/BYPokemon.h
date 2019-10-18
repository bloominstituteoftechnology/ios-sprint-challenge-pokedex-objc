//
//  BYPokemon.h
//  pokedex-objc
//
//  Created by Bradley Yin on 10/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYPokemon : NSObject

@property (copy, nonnull, nonatomic) NSString *name;
@property (copy, nonnull, nonatomic) NSURL *url;
@property (copy, nullable, nonatomic) NSNumber *pokeId;
@property (copy, nullable, nonatomic) NSString *abilities;

- (instancetype _Nonnull)initWithDictionary:(NSDictionary *_Nonnull)dictionary;

@end

