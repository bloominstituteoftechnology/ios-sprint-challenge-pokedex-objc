//
//  UFOPokemon.h
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface UFOPokemon : NSObject

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sprite;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic) NSURL *url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end




NS_ASSUME_NONNULL_END
