//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

@interface PokedexTableViewController ()

@property PokemonAPIClient *apiClient;
@property NSArray<Pokemon *> *pokemon;

- (void)setUp;
@end

@implementation PokedexTableViewController

//MARK: - Inits

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if(!self) {
        return nil;
    }
    
    [self setUp];
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(!self) {
        return nil;
    }
    
    [self setUp];
    return self;
}

- (void)setUp {
    _apiClient = [[PokemonAPIClient alloc] init];
}







- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}


@end
