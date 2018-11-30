//
//  DYPPokemon.h
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYPPokemon : NSObject

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSString *)abilities sprite:(NSURL *)sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, nullable) NSString *abilities;
@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *identifier;
@property (nonatomic, copy, nullable) NSURL *sprite;

@end
