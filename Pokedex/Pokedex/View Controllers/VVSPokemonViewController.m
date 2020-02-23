//
//  VVSPokemonViewController.m
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPokemonViewController.h"
#import <UIKit/UIKit.h>

@interface VVSPokemonViewController ()

@end

@implementation VVSPokemonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.pokemonController fetchPokemonWithName:self.pokemon.name completion:^(VVSPokemon * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }

        NSData *imageData = [[NSData alloc] initWithContentsOfURL:pokemon.spriteURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:imageData];
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", pokemon.identifier];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", [[pokemon abilities] componentsJoinedByString:@", "]];
        });
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
