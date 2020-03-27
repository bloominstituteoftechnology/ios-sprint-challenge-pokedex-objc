//
//  DetailViewController.m
//  Pokedex
//
//  Created by Alexander Supe on 27.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

#import "DetailViewController.h"
#import "Pokedex-Swift.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;

@end

@implementation DetailViewController

- (void)configureView {
    if (self.pokemon) {
        
        self.title = [self.pokemon.name capitalizedString];
        
        if (self.pokemon.identifier) {
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        }
        
        if (self.pokemon.abilities) {
            NSString *abilityString = [self.pokemon.abilities componentsJoinedByString:@", "];
            self.abilityLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"sprite"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureView];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:nil];
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    [self configureView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.pokemon removeObserver:self forKeyPath:@"sprite"];
}

@end
