//
//  JGPAbility.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//NS_SWIFT_NAME(Ability)
@interface JGPAbility : NSObject

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithDictionary:(id)dictionary;

@end

NS_ASSUME_NONNULL_END

