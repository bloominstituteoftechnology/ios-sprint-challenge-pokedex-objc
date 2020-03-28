//
//  JACPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACPokemonTableViewController.h"
#import "JACPokemonDetailViewController.h"
#import "Pokedex_Objc-Swift.h"
#import "JACPokemon.h"

@interface JACPokemonTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *pokemonSearchBar;

@property PokemonController *controller;
@property NSMutableArray<JACPokemon *> *pokemon;

@end

@implementation JACPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _controller = [[PokemonController alloc] init];
        _pokemon = [NSMutableArray arrayWithArray:[_controller loadPokemon]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonSearchBar.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savePokemon) name:@"pokemonDetailsSet" object:nil];
    
    [self updateViews];
    
    UIColor *top = [UIColor colorWithRed:0.93 green:0.12 blue:0.11 alpha:1.0];
    UIColor *mid = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.0];
    
    [self updateNavWithTopColor:top midColor:mid];
}

- (void)savePokemon {
    [_controller saveWithPokemon:_pokemon];
    [self updateViews];
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor *mid = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.0];
        
        [self.pokemonSearchBar setBackgroundColor:mid];
        [self.pokemonSearchBar setBarTintColor:mid];
        [self.pokemonSearchBar setTintColor:mid];
        [[self.pokemonSearchBar searchTextField] setTextColor:[UIColor whiteColor]];
        [[self.pokemonSearchBar searchTextField] setTintColor:[UIColor whiteColor]];
        
        [self.tableView setTableFooterView:[[UIView alloc] init]];
        [self.tableView reloadData];
    });
}

- (void)updateNavWithTopColor:(UIColor *)top midColor:(UIColor *)mid {
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [appearance setLargeTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [appearance setBackgroundColor:top];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setCompactAppearance:appearance];
    [bar setStandardAppearance:appearance];
    [bar setScrollEdgeAppearance:appearance];
    [bar setTintColor:[UIColor whiteColor]];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    UIColor *bot = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    JACPokemon *cellPokemon = [_pokemon objectAtIndex:[indexPath row]];
    
    if (cellPokemon.image == NULL) {
        [_controller fetchPokemonImageFor:cellPokemon];
    }
    
    cell.textLabel.text = cellPokemon.name;
    [cell setBackgroundColor: bot];
    [cell.imageView setImage:cellPokemon.image];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    JACPokemonDetailViewController *detailVC = [segue destinationViewController];
    
    if ([[segue identifier] isEqual:@"ShowPokemonSegue"]) {
        JACPokemon *detailPokemon = [self.pokemon objectAtIndex:(int)[self.tableView.indexPathForSelectedRow row]];
        detailVC.controller = self.controller;
        detailVC.title = detailPokemon.name;
        detailVC.pokemon = detailPokemon;
    }
}

#pragma mark - Delegate Functions

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *pokemonText = [searchBar text];
    [_controller getPokemonWith:pokemonText completion:^(JACPokemon * _Nullable newPokemon, NSError * _Nullable error) {
        if (error) {
            return;
        }
        for (int i=0; i<[self.pokemon count]; i++) {
            if ([self.pokemon objectAtIndex:i].name == newPokemon.name) {
                return;
            }
        }
        
        [self.pokemon addObject:newPokemon];
        [self savePokemon];
    }];
}

@end
