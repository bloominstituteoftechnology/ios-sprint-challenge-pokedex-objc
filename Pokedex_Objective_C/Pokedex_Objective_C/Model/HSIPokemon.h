//
//  HSIPokemon.h
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSIPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *url;

-(instancetype) initWithName:(NSString *)name url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
