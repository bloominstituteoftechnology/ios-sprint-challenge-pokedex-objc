//
//  LYDPokemon.h
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(LYDPokemon)

@interface LYDPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *imageURLStr;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithDic:(NSDictionary *)pokeDic;
- (instancetype)initWithName:(NSString *)name;

@end


