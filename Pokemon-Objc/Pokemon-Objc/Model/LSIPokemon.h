//
//  LSIPokemon.h
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSIPokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) int identifier;
@property (nonatomic) NSString *sprite;
@property (nonatomic) NSArray<NSString *> *abilities;

@end
