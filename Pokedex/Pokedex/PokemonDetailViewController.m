//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

static NSString *identifier = @"identifier";

@interface PokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.pokemon addObserver:self forKeyPath:identifier options:0 context:nil];
        [PokemonController.sharedController fillInDetailsFor:self.pokemon];
      //  [self updateViews];
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:identifier];
}

- (void)updateViews
{
    if(self.pokemon)
    {
        self.pokemonNameLabel.text = [self.pokemon.name capitalizedString];
        self.pokemonIDLabel.text = [[NSString alloc] initWithFormat:@"%@", self.pokemon.identifier];

        NSString *abilitiesString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
        self.pokemonAbilitiesLabel.text = abilitiesString;
        
        if (self.pokemon.spriteURL)
        {
//            NSURL *url = [NSURL URLWithString:self.pokemon.spriteURL];
            NSLog(@"%@", self.pokemon.spriteURL);
            NSLog(@"is the URL type:%@", [self.pokemon.spriteURL isKindOfClass:[NSURL class]]? @"Yes" : @"No");
            [[NSURLSession.sharedSession dataTaskWithURL:self.pokemon.spriteURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = [UIImage imageWithData:data];
                    });
                }
            }] resume];
        } else {
            NSLog(@"URL is invalid");
        }
    }
}

- (void)fetchAndShowImage
{
//    NSURL *url = [NSURL URLWithString:self.pokemon.spriteURL];
//    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (data) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = [UIImage imageWithData:data];
//            });
//        }
//    }] resume];
//    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//      {
//        if (error) {
//            NSLog(@"Failed to fetch image for pokemon: %@", self.pokemon.name);
//            return;
//        }
//
//        if (data == nil) {
//            NSLog(@"Data was returned nil");
//            return;
//        }
//
//        UIImage *sprite = [UIImage imageWithData:data];
//
//        if (sprite) {
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                self.imageView.image = sprite;
//            });
//        } else {
//            NSLog(@"Failed to convert data into sprite");
//        }
//    }] resume];
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
