//
//  MJRPokemonDetailViewController.m
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/7/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

#import "MJRPokemonDetailViewController.h"
#import "MJRPokemon.h"
#import "Pokedex_2_0-Swift.h"

void *KVOContext = &KVOContext;

@interface MJRPokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pokemonSprite;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *identifierLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation MJRPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) updateViews
{
    if (self.pokemon) {
        
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        self.identifierLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        
        NSString *abilitiesString = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilitiesString];
        
        [self setImage];
    }
}

-(void) setImage
{
    NSURL *imageURL = self.pokemon.sprite;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            NSLog(@"Error getting image %@", error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"No data returned from data task");
            return;
        }
        
        UIImage *sprite = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self pokemonSprite] setImage:sprite];
        });
        
    }];
    
    [dataTask resume];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == KVOContext) {
        
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

- (void)setPokemon:(MJRPokemon *)pokemon
{
    if (pokemon != _pokemon)
    {
        _pokemon = pokemon;
        
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

@end
