//
//  HSIPokemon.h
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSIPokemon : NSObject

//initialized properties
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *url;

//can be added later
@property (nonatomic, copy) UIImage *image;
@property (nonatomic) NSMutableArray<NSString *> *abilities;
@property (nonatomic, copy) NSString *identifier;


-(instancetype) initWithName:(NSString *)name url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
