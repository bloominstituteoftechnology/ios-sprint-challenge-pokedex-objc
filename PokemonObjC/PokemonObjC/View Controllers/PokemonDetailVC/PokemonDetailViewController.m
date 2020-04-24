//
//  PokemonDetailViewController.m
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "PokemonObjC-Swift.h"

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    if (self.pokemon) {
        
        self.title = [self.pokemon.name capitalizedString];
        
        if (self.pokemon.identifier) {
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        }
        
        if (self.pokemon.abilities) {
            NSString *abilityString = [self.pokemon.abilities componentsJoinedByString:@", "];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
        }
        
        if (self.pokemon.sprite) {
            NSURL *url = [NSURL URLWithString:self.pokemon.sprite];
            [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = [UIImage imageWithData:data];
                    });
                }
            }] resume];
        }
    }
}

@end
