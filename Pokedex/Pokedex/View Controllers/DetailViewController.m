//
//  DetailViewController.m
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

#import "DetailViewController.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property (weak, nonatomic) UIColor *bgColor;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI shared] fetchPokemonObjectWithPokemon:[self pokemon]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}



- (void)setPokemon:(NKTPokemon *)pokemon
{
    if (pokemon != _pokemon)
    {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc;
{
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:&KVOContext];
}


- (void)updateViews
{
    NSURL *imageURL = [NSURL URLWithString:self.pokemon.imageURL];
    
    [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error getting image%@", error);
        }
        
        if (data)
        {
            UIImage *pokemon = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self imageView] setImage:pokemon];
            });
        }
    }].resume;
    
    self.nameLabel.text = [NSString stringWithFormat:@"Hi! My name is %@", self.pokemon.name.capitalizedString];
    
    NSString *abilities = [NSString stringWithFormat:@"Abilities: %@", [[[self pokemon] abilities] componentsJoinedByString:@", "]];
    self.abilitiesLabel.text = abilities;
    
    self.idLabel.text = [NSString stringWithFormat:@"ID: %ld", self.pokemon.pokemonID];
    
}



@end
