//
//  CDGPokemon.h
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDGPokemon : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic, nullable)NSString *identifier;
@property (nonatomic, nullable)NSString *sprite;
@property (nonatomic, nullable)NSArray<NSString *> *abilities;
@property (nonatomic)NSString *urlString;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
