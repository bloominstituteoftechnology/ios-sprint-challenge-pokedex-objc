//
//  TSAPokemon.h
//  Pokedex
//
//  Created by Alex Thompson on 6/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)
@interface TSAPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) int identifier;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSArray *abilites;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
