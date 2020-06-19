//
//  BRDPokemon.h
//  Pokedex-2
//
//  Created by Bradley Diroff on 6/19/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRDPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) int identifier;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSArray *abilities;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
