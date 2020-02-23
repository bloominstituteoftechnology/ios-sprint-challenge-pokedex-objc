//
//  PokemonDetail.h
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetail : NSObject

//MARK: - Initialization

- (instancetype)initWithName:(NSString *)name id:(NSString *)id sprite:(NSString *)sprite abilities:(NSArray<NSString *> *)abilities;

//MARK: - Properties

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *id;
@property (nonatomic, readonly, copy) NSString *sprite;
@property (nonatomic, readonly, copy) NSArray<NSString *> *abilities;

@end

NS_ASSUME_NONNULL_END
