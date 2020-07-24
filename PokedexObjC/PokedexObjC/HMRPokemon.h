//
//  HMRPokemon.h
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMRPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic, nullable)NSString *type;
@property (nonatomic, copy) NSString *detailURL;
@property (nonatomic, copy) NSString *sprite;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
