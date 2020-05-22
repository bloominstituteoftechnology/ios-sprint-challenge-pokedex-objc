//
//  OTKPokemon.h
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface OTKPokemon : NSObject

@property (nonatomic, nonnull, copy) NSString *name;
@property (nonatomic, nonnull) NSURL *url;
@property (nonatomic, nullable) NSMutableArray<NSString *> *abilities;
@property (nonatomic, nonnull) NSNumber *identifier;
@property (nonatomic, nullable) NSURL *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
