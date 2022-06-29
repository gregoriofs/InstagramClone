//
//  HomeFeedViewController.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "PostCell.h"
#import "PostDetailsViewController.h"



@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, finishedPostingDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIRefreshControl *refreshControl;


@end

@implementation HomeFeedViewController



- (IBAction)didTapLogOut:(id)sender {
    
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LogInViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self fetchPosts];
    
}


-(void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfPosts.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.arrayOfPosts[indexPath.row];
    
    NSDate *createdAt = post.createdAt;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"MM/d/y, hh:mm aa";
    
    cell.timeStamp.text = [formatter stringFromDate:createdAt];
    
    cell.caption.text = post.caption;
    
    PFUser *user = [PFUser currentUser];
    
    cell.userName.text = [NSString stringWithFormat:@"%@:",user.username];
    
    [cell setPost:post];
    
    cell.numLikes.text = [NSString stringWithFormat:@"%d",post.likeCount.intValue];
    
    return cell;
}

//Method for refreshing tableview
-(void)beginRefresh:(UIRefreshControl *)refreshControl{
    
    [self fetchPosts];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier]  isEqual: @"postDetailsSegue"]){
        
        PostDetailsViewController *newVC = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        
        Post *currPost = self.arrayOfPosts[path.row];
        
        newVC.post = currPost;
    }
    else{
        
        UINavigationController *navigationController = [segue destinationViewController];
        PostViewController *newController = (PostViewController*)navigationController.topViewController;
        newController.delegate = self;
        
    }
}

-  (void)finishedPost{
    
    [self fetchPosts];
    
}

@end
