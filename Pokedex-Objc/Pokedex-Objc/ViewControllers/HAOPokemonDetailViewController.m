//
//  HAOPokemonDetailViewController.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemonDetailViewController.h"
#import "HAOPokemon.h"

#import "Pokedex_Objc-Swift.h"

static NSString *identifier = @"identifier";

@interface HAOPokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonAbilitesLabel;

- (void)fetchAndSetImage;

@end

@implementation HAOPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.pokemon) {
        [self.pokemon addObserver:self forKeyPath:identifier options:0 context:nil];
        [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:identifier];
}

- (void)updateViews
{
    self.pokemonNameLabel.text = [self.pokemon.name capitalizedString];
    self.pokemonIDLabel.text = [[NSString alloc] initWithFormat:@"%@", self.pokemon.identifier];
    
    NSString *abilitiesString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
    self.pokemonAbilitesLabel.text = abilitiesString;
    
    [self fetchAndSetImage];
}

- (void)fetchAndSetImage
{
    [[NSURLSession.sharedSession dataTaskWithURL:self.pokemon.spriteURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        if (error) {
            NSLog(@"Failed to fetch image for pokemon: %@", self.pokemon.name);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data was returned nil");
            return;
        }
        
        UIImage *sprite = [UIImage imageWithData:data];
        
        if (sprite) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.imageView.image = sprite;
            });
        } else {
            NSLog(@"Failed to convert data into sprite");
        }
    }] resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:identifier]) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
