//
//  JSPokeListVC.m
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPokeListVC.h"
#import "JSPokeDetailsVC.h"
#import "JSPokeLink.h"
#import "Pokedex_C-Swift.h"

@interface JSPokeListVC ()

@property PokeController *pokeController;

@end

@implementation JSPokeListVC

// MARK: - IBOutlets


// MARK: - Properties



// MARK: - Life Cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		_pokeController = [[PokeController alloc] init];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.pokeController getPokeListWithCompletion:^(BOOL didLoad) {
		if (didLoad) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.tableView reloadData];
			});
		}
	}];
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.destinationViewController isKindOfClass:JSPokeDetailsVC.self]) {
		JSPokeDetailsVC *detailsVC = [segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		
		detailsVC.pokecontroller = self.pokeController;
		detailsVC.pokeName = self.pokeController.pokeList[indexPath.row].name;
	}
}

// MARK: - IBActions


// MARK: - Helpers


// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.pokeController.pokeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
	cell.textLabel.text = self.pokeController.pokeList[indexPath.row].name;
    
    return cell;
}

@end
