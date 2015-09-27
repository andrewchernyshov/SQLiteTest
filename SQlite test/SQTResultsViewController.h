//
//  SQTResultsViewController.h
//  SQlite test
//
//  Created by Andrew Chernyhov on 28.09.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SQTResultsViewController : UIViewController

@property (nonatomic) sqlite3 *DB;

@end
