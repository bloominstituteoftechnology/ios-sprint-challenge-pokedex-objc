//
//  SLRDetailViewController.m
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRDetailViewController.h"
#import "SLRPokemon.h"
#import "Pokedex-Swift.h"


@interface SLRDetailViewController ()

@property PokemonAPI *apiDetailFetch;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SLRDetailViewController

// MARK: - View States
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:NULL];
    _apiDetailFetch = [[PokemonAPI alloc] init];
    [self.apiDetailFetch fillInDetailsFor:self.pokemon];
}

- (void)viewWillDisappear:(BOOL)animated {
  //  [self observationDone];
}

// MARK: - Functions
-(void) getSprite: (NSString *) fileName{
    
    NSURL *url = [NSURL URLWithString: fileName];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            NSLog(@"Error with image loading: %@", error);
        }
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self imageView] setImage:image];
        });
        
    }] resume];
}

// MARK: - Functions
- (void) displayDetail {
    if(![self.pokemon pokemonName] && ![self isViewLoaded]) {
        return;
    }
    
    // Display the detail
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:self.pokemon.pokemonName];
        [self getSprite: [self.pokemon sprite]];
        self.pokemonNameLabel.text = self.pokemon.pokemonName;
        self.idLabel.text = self.pokemon.pokemanID;
        self.abilitiesLabel.text = [self.pokemon abilities];
    });
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self displayDetail];
}

@end
