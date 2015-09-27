//
//  SQTViewController.h
//  SQlite test
//
//  Created by Andrew Chernyhov on 27.09.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface SQTViewController : UIViewController

@property (nonatomic) sqlite3 *DB;

@end
