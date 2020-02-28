//
//  CARPokemon.h
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Pokemon)
@interface CARPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *pokemonId;
@property (nonatomic, copy) NSString *spriteURL;
@property (nonatomic) NSArray<NSString*> *abilities;

- (instancetype)initWithName:(NSString *)name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
