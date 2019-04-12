//
//  NYCDetailViewController.m
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

#import "NYCDetailViewController.h"
#import "NYCPokemon.h"
#import <Pokedex-Swift.h>

void *kvoContext = &kvoContext;

@interface NYCDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation NYCDetailViewController

- (void)updateViews {
    
    if (self.pokemon != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.pokemon.abilities != nil && self.pokemon.name != nil && self.pokemon.identifier != nil) {
                
                [self.pokemonNameLabel setText:self.pokemon.name.capitalizedString];
                [self.pokemonIdentifierLabel setText:self.pokemon.identifier.stringValue];
                
                NSString *abilities = [self.pokemon.abilities componentsJoinedByString:@", "];
                [self.pokemonAbilitiesLabel setText:abilities.capitalizedString];
            }
        });
    }
}

- (void)setUpImage {
    
    if (self.pokemon.spriteURL != nil) {
        
        PokemonAPI *controller = [PokemonAPI sharedController];
        
        [controller fetchImageWithURL:self.pokemon.spriteURL completionBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error completing fetch request: %@", error);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *image = [UIImage imageWithData:data];
                self.pokemonImageView.image = image;
            });
        }];
    }
}

- (void)setPokemon:(NYCPokemon *)pokemon {
    [_pokemon removeObserver:self forKeyPath:@"identifier" context:kvoContext];
    [_pokemon removeObserver:self forKeyPath:@"spriteURL" context:kvoContext];
    [_pokemon removeObserver:self forKeyPath:@"abilities" context:kvoContext];
    
    _pokemon = pokemon;
    PokemonAPI *controller = PokemonAPI.sharedController;
    [controller fillInDetailsFor:pokemon];
    
    [_pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:kvoContext];
    [_pokemon addObserver:self forKeyPath:@"spriteURL" options:NSKeyValueObservingOptionInitial context:kvoContext];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:kvoContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kvoContext) {
        [self updateViews];
        
        if ([keyPath isEqualToString:@"spriteURL"]) {
            [self setUpImage];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
