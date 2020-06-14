//
//  CLBPokemon.h
//  Pokedex - Obj-C
//
//  Created by Christian Lorenzo on 6/13/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLBPokemon : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic, nullable)NSString *identifier;
@property (nonatomic, nullable)NSString *sprite;
@property (nonatomic, nullable)NSArray<NSString *> *abilities;
@property (nonatomic)NSString *urlString;
@property (nonatomic, nullable)NSString *type;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
