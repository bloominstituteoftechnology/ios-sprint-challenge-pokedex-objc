//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokedex-Bridging-Header.h"
#import "Pokedex-Swift.h"

@interface PokemonDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *sprite;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *abiltiesLabel;
@property (nonatomic, weak) IBOutlet UILabel *typeLabel;

- (void)updatePokemon;
- (void)updateLabels;
- (void)updateImage;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemon addObserver:self
                   forKeyPath:@"sprite"
                      options: 0
                      context: nil];
    
    [self.pokemon addObserver:self
                   forKeyPath:@"abilities"
                      options:0
                      context:nil];
    
    [PokemonController.shared getPokemonDetailFor:_pokemon];

    [self updatePokemon];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - Utility
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"sprite"]) {
        [self updateImage];
    }
    
    if ([keyPath isEqualToString:@"abilities"]) {
        [self updateLabels];
    }
}

- (void)updatePokemon {
    if (self.pokemon) {
        [self updateImage];
        [self updateLabels];
    } else {
        NSLog(@"Pokemon was null");
        return;
    }
}

- (void)updateImage {
    if (self.pokemon.sprite) {
        [[NSURLSession.sharedSession
          dataTaskWithURL:[NSURL URLWithString:self.pokemon.sprite]
          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.sprite.image = [UIImage imageWithData:data];
                });
            }
        }] resume];
    }
}

- (void)updateLabels {
    if (self.pokemon.name) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [self.pokemon.name capitalizedString]];
        });
    }
    
    if (self.pokemon.identifier) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        });
    }
    
    if (self.pokemon.abilities) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.abiltiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", self.pokemon.abilities];
        });
    }

    if (self.pokemon.type) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.typeLabel.text = [NSString stringWithFormat:@"Types: %@", self.pokemon.type];
        });
    }
}

@end
