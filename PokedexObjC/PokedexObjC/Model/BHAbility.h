//
//  BHAbility.h
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHAbility : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, getter=isHidden) BOOL hidden;

-(instancetype)initWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
