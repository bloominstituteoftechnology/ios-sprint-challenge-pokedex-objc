//
//  IJLPokemon.h
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Pokemon)
@interface IJLPokemon : NSObject

@property (nonatomic, nonnull, readonly) NSString *name;
@property (nonatomic, nullable, readonly) NSURL *spriteURL;
@property (nonatomic, nullable, readonly) NSArray<NSString *> *abilities;
@property int identifier;

- (nonnull instancetype)initWithName:(nonnull NSString *)name;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

- (void)updateFromDictionary:(nonnull NSDictionary *)dictionary;

@end
