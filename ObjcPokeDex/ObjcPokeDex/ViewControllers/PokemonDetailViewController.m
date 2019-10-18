//
//  PokemonDetailViewController.m
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import "PokemonDetailViewController.h"

@interface PokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pokeImage;
@property (strong, nonatomic) IBOutlet UILabel *pokeName;

@property (strong, nonatomic) IBOutlet UILabel *pokeID;

@property (strong, nonatomic) IBOutlet UILabel *pokeAbilities;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


-(void)updateViews {
    if (!self.isViewLoaded || !self.pokemon) {return;}
    
}



@end
