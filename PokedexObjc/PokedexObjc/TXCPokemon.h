//
//  TXCPokemon.h
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCPokemon : NSObject

@property (nonatomic, nonnull, copy) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic, copy) NSMutableArray *abilities;
@property NSString *sprite;

- (instancetype)initWithName:(NSString *)name
                  identifier:(id)identifier
                 alibilities:(NSArray *)abilities
                      sprite:(NSString *)sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
