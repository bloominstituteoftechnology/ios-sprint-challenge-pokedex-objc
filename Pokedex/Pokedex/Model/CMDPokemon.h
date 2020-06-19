//
//  CMDPokemon.h
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDPokemon : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic, nullable)NSString *identifier;
@property (nonatomic, nullable)NSString *sprite;
@property (nonatomic, nullable)NSArray<NSString *> *abilities;
@property (nonatomic)NSString *urlString;
@property (nonatomic, nullable)NSString *type;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
