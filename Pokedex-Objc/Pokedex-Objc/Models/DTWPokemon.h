//
//  DTWPokemon.h
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTWPokemonDetail;

NS_SWIFT_NAME(Pokemon)
@interface DTWPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nullable) NSURL *detailsURL;

@property (nonatomic, readwrite, nullable) DTWPokemonDetail *details;
@property (nonatomic, readwrite, nullable) UIImage *sprite;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                 URL:(nullable NSURL *)detailsURL;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
