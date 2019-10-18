//
//  PokemonDetailViewController.m
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "LSIPokemon.h"

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
    self.pokeName.text = self.pokemon.name;
    self.pokeID.text = [self.pokemon.ID stringValue];
    for (NSString *ability in self.pokemon.abilites) {
        [self.pokeAbilities.text stringByAppendingString:ability];
    }
    NSURL *imageURL = [NSURL URLWithString:self.pokemon.spriteURLString];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching image");
            return;
        }
         NSError *jsonError = nil;
    
        if (jsonError) {
            NSLog(@"JSON Error %@", jsonError);
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        self.pokeImage.image = image;
    }];
    [task resume];
    
}



@end
