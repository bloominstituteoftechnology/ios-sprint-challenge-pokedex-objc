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
@property (nonatomic, copy) NSString *detailURL;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSArray *abilities;

- (instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL;

@end

NS_ASSUME_NONNULL_END
