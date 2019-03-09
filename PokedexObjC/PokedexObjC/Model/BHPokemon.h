//
//  BHPokemon.h
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BHAbility;

@interface BHPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, nullable) NSString *speciesName;
@property (nonatomic, readonly, nullable) NSArray<BHAbility *> *abilities;

@property (nonatomic, readonly, nullable) NSArray<NSString *> *moves;
@property (nonatomic, readonly, nullable) NSString *identifier;
@property (nonatomic, readonly, nullable) NSArray<NSURL *> *images;
@property (nonatomic, readonly) NSString *moreInfoURLString;

-(instancetype)initWithJSON:(id)json;
-(BHPokemon*)updateWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
