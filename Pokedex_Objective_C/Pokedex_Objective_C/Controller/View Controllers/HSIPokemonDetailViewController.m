//
//  HSIPokemonDetailViewController.m
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "HSIPokemonDetailViewController.h"
#import "HSIPokemon.h"
#import "Pokedex_Objective_C-Swift.h"

@interface HSIPokemonDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HSIPokemonDetailViewController

NetworkService *networkService;

- (void)viewDidLoad {
    [super viewDidLoad];
    //init controller
    networkService = [[NetworkService alloc] initWithDataLoader:NSURLSession.sharedSession];
    if (_pokemon) {
        __weak typeof(self) weakSelf = self;
        [networkService getPokemonAbilitiesWithPokemon: self.pokemon completion:^{
            __strong typeof(self) strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^(void){
                strongSelf.abilitiesLabel.text = [self.pokemon.abilities componentsJoinedByString:@", "];
                strongSelf.imageView.image = self.pokemon.image;
            });

        }];
    }

}

@end
