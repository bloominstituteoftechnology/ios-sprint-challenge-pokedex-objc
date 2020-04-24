//
//  KMLPokemonDetailViewController.m
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import "KMLPokemonDetailViewController.h"
#import <UIKit/UIKit.h>

void *KVOContext = &KVOContext;

@interface KMLPokemonDetailViewController ()

@end

@implementation KMLPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonController addObserver:self
                             forKeyPath:@"pokemon"
                                options:kNilOptions
                                context:KVOContext];
    
    [self.pokemonController fillInDetails:self.pokemon];
}

- (void)dealloc
{
    [self.pokemonController removeObserver:self
                                forKeyPath:@"pokemon"
                                   context:KVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            KMLPokemon *pokemon = self.pokemonController.pokemon;
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:pokemon.spriteURL];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:imageData];
                self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
                self.idLabel.text = [NSString stringWithFormat:@"ID: %@", pokemon.identifier];
                self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", [[pokemon abilities] componentsJoinedByString:@", "]];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
