//
//  NSURL+Secure.h
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Secure)

- (nullable NSURL *)URLUsingHTTPS;

@end
