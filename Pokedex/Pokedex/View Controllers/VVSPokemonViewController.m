//
//  VVSPokemonViewController.m
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPokemonViewController.h"
#import <UIKit/UIKit.h>

void *KVOContext = &KVOContext;

@interface VVSPokemonViewController ()

@end

@implementation VVSPokemonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver:self
           forKeyPath:@"pokemon"
              options:kNilOptions
              context:KVOContext];
    
    [self.pokemonController fetchPokemonWithName:self.pokemon.name completion:^(VVSPokemon * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemon = pokemon;
        });
    }];
}

- (void)dealloc
{
    [self removeObserver:self
              forKeyPath:@"pokemon"
                 context:KVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.pokemon.spriteURL];
        
            self.imageView.image = [UIImage imageWithData:imageData];
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [self.pokemon.name capitalizedString]];
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", [[self.pokemon abilities] componentsJoinedByString:@", "]];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
