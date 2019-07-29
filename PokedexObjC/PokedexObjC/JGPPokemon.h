//
//  JGPPokemon.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGPAbility.h"

NS_SWIFT_NAME(Pokemon)
@interface JGPPokemon : NSObject

// double check if initWithName can be _Nonnull here... (what if Networking fails? error in networking should take care of that, but double-check with PM
@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic) int identifier;                  // uh-oh, how do you nullable an int?
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic, copy, nullable) NSArray<JGPAbility *> *abilities;


- (nonnull instancetype) initWithName:(NSString *_Nonnull)name
                           identifier:(int)identifier
                               sprite:(NSString *_Nullable)sprite
                            abilities:(NSArray<JGPAbility *> *_Nullable)abilities;

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dictionary;

- (NSString *_Nonnull)description;



@end




