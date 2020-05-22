//
//  WAHPokemon.h
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAHPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy, nullable) NSString *urergherugl;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
