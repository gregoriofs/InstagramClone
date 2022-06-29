//
//  ProfileViewController.h
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "PostCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
