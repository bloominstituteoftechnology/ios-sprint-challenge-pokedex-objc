//
//  CARListPokemon.h
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(ListPokemon)
@interface CARListPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithName:(NSString *)name
                         url:(NSString *)url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
