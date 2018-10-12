//
//  DetailViewController.m
//  Pokedex
//
//  Created by Andrew Dhan on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

#import "AELDetailViewController.h"
#import "Pokedex-Swift.h"
#import "AELPokemon.h"

@interface AELDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation AELDetailViewController


//- (void)viewDidLoad
//{
//    //TEST loadimage function
//    [super viewDidLoad];
//    [self loadImageWithStringPath:@"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png"];
//    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pokemon addObserver:self forKeyPath:@"id" options:0 context:NULL];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateName];
    [PokemonAPI.sharedController fillInDetailsFor: self.pokemon];
}

-(void) updateName{
    if (![self isViewLoaded] && [self pokemon]){
        return;
    }
    
    [self setTitle:[self.pokemon name]];
    [[self nameLabel] setText:[self.pokemon name]];
}
-(void) updateViews
{
    if (![self isViewLoaded] && [self pokemon]){
        return;
    }
    
    [[self idLabel] setText: [self.pokemon id]];
    [[self abilitiesTextView] setText:[self.pokemon abilities]];
    [self loadImageWithStringPath:[self.pokemon sprite]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateViews];
    NSLog(@"%@", [object valueForKeyPath:keyPath]);
}



-(void) loadImageWithStringPath: (NSString *) path{
    
    NSURL *url = [NSURL URLWithString: path ];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable r, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error loading image: %@", error);
        }
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self spriteImageView] setImage:image];
        });
        
    }] resume];
    
}
@end
