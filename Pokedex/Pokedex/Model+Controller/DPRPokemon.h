//
//  DPRPokemon.h
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_SWIFT_NAME(Pokemon)
@interface DPRPokemon : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nullable) NSURL *spriteURL;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, nonnull) NSURL *url;
@property (nonatomic, nullable) NSInteger *identifier;

- (nonnull instancetype)initWithName:(nonnull NSString *)name URL:(nonnull NSURL *)url;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end


