//
//  ViewController.m
//  2023淘宝最新地址选择
//
//  Created by 李明 on 2023/8/11.
//

#import "ViewController.h"
#import "MMChooseAddressView.h"

@interface ViewController ()<MMChooseAddressViewDelegate>


@property (nonatomic, strong) UILabel *lab;


@property (nonatomic, strong) MMChooseAddressView *view2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 300, 30)];
    lab.textColor = [UIColor blackColor];
    [self.view addSubview:lab];
    self.lab = lab;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 200, 200, 30);
    [btn1 setTitle:@"点击弹出" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 280, 200, 30);
    [btn2 setTitle:@"点击弹出,并传值" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn2];
    
    
}


-(void)btn1Click{
    MMChooseAddressView *view = [[MMChooseAddressView alloc]init];
    view.delegate = self;
    [view show];
}


-(void)btn2Click{
    MMChooseAddressView *view2 = [[MMChooseAddressView alloc]init];
    view2.delegate = self;
    [view2 show];
    
    
    self.view2 = view2;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 这部分代码会在 1 秒后执行
                NSLog(@"1 秒后执行的操作");
        
//        NSString *codes = @"110000,110100,110101";
        
        NSString *codes = @"110000,110100,110101,110101001";

        [self.view2 setCodesString:codes];
    });
    
    
}
-(void)mmChooseAddressViewDidSelectedArr:(NSMutableArray *)selectedArr{
    
    NSMutableArray *codeArray = [NSMutableArray array];
    NSMutableArray *nameArray = [NSMutableArray array];

    // 遍历 dataArr，将每个 MMAddressDataModel 对象的 code 和 name 属性分别添加到对应的数组中
    for (MMAddressDataModel *model in selectedArr) {
        [codeArray addObject:model.code];
        [nameArray addObject:model.name];
    }

    // 使用 componentsJoinedByString: 方法将数组元素逗号分隔拼接成字符串
    NSString *joinedCodes = [codeArray componentsJoinedByString:@", "];
    NSString *joinedNames = [nameArray componentsJoinedByString:@", "];

   
    self.lab.text = joinedNames;
}

@end

