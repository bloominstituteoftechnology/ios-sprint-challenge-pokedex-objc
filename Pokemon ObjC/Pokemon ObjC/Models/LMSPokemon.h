//
//  LMSPokemon.h
//  Pokemon ObjC
//
//  Created by Lisa Sampson on 3/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSAbility.h"
#import "LMSSprite.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMSPokemon : NSObject

@property NSString *name;
@property NSInteger identifier;
@property NSArray <LMSAbility *> *abilities;
@property NSArray <LMSSprite *> *sprites;

@end

NS_ASSUME_NONNULL_END
