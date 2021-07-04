//
//  JDBAbility.h
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDBAbility : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, getter=isHidden) BOOL hidden;

- (instancetype)initWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
