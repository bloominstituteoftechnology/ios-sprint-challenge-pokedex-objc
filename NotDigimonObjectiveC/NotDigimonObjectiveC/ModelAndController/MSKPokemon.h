//
//  MSKPokemon.h
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSKPokemon: NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, assign) NSString *identifier;
@property (nonatomic, assign) NSString *sprite;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSString *)identifier
                     sprite:(NSString *)sprite
                  abilities:(NSArray<NSString *> *)abilities;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
NS_ASSUME_NONNULL_END
