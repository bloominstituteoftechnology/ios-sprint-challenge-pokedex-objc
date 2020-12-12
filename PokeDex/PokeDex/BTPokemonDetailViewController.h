//
//  BTPokemonDetailViewController.h
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import <UIKit/UIKit.h>

@class BTPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface BTPokemonDetailViewController : UIViewController

@property BTPokemon *pokemon;

-(void)downloadImageWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
