//
//  GIPPokemon.h
//  Pokedex-Objc
//
//  Created by Gi Pyo Kim on 12/20/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_SWIFT_NAME(Pokemon)
@interface GIPPokemon : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nullable) UIImage *sprite;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, nonnull) NSURL *detailURL;

- (nonnull instancetype)initWithName:(nonnull NSString *)name detailURL:(nonnull NSURL *)detailURL;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

- (void)fillInDetailsFor:(nonnull GIPPokemon *)pokemon dictionary:(nonnull NSDictionary *)dictionary;

@end

