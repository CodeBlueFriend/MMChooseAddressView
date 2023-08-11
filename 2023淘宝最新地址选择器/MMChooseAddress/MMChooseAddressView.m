//
//  MMChooseAddressView.m
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/7.
//

#import "MMChooseAddressView.h"


@interface MMChooseAddressView ()<UITableViewDelegate,UITableViewDataSource,MMAddressSelectedViewDelegate>
{
    
    CGFloat selectedViewHeight;//已选view高度
    CGFloat listViewHeight;//列表高度
}
/*
 半透明view
 */
@property (nonatomic, strong) UIView *maskView;

/*
 内容view
 */
@property (nonatomic, strong) UIView *contentView;

/*
 顶部titleView
 */
@property (nonatomic, strong) UIView *topView;


/*
 选择的地址view
 */
@property (nonatomic, strong) UIView *selectedView;


/*
  供选择的地区列表
 */
@property (nonatomic, strong) UITableView *listView;


/*
 解析到的地址集合
 */
@property (nonatomic, strong) NSMutableArray *allAddressArr;

/*
 所选择的地址集合
 */
@property (nonatomic, strong) NSMutableArray *selectedAddressArr;


/*
 当前列表的地址集合
 */
@property (nonatomic, strong) NSMutableArray *currentListArr;



@end
@implementation MMChooseAddressView


-(instancetype)init{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        [self addSubview:self.maskView];
        [self.maskView addSubview:self.contentView];
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.selectedView];
        [self.contentView addSubview:self.listView];
        
        
        
        // 在你的方法中调用以下代码
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 这部分代码会在 1 秒后执行
            NSLog(@"1 秒后执行的操作");
            // 在这里执行你想要延迟执行的操作..
        //        });

            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mmmAddress" ofType:@"json"];
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            NSArray *data_arr =  [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:nil];
            
            NSArray *dataArr = [MMAddressDataModel mj_objectArrayWithKeyValuesArray:data_arr];
            

            [self.allAddressArr removeAllObjects];
            [self.allAddressArr addObjectsFromArray:dataArr];
            [self reloadUI];


        
        

    }
    return self;
}



#pragma mark ----------------------- 懒加载-------------------
-(UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _maskView;
}

-(UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - 540, self.maskView.frame.size.width, 540)];
        _contentView.backgroundColor = WhiteColor;
        [_contentView mm_setPartCornerRadious:22.5 borderColor:ClearColor borderWidth:0 forRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight ];
    }
    return _contentView;
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 45)];
        _topView.backgroundColor = RGB(244, 249, 255);
        [_topView mm_setPartCornerRadious:22.5 borderColor:ClearColor borderWidth:0 forRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight ];

        UILabel *titleLabel = [[UILabel alloc]initWithFrame:_topView.bounds];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = kPFFont(16);
        titleLabel.textColor = RGB(51, 51, 51);
        titleLabel.text = @"请选择所在地区";
        [_topView addSubview:titleLabel];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(self.contentView.frame.size.width - 32 - 22, 0, 32, 45);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = kPFFont(15);
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_topView addSubview:cancelBtn];
        
    }
    return _topView;
}

-(UIView *)selectedView{
    if(!_selectedView){
        _selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, self.maskView.frame.size.width, selectedViewHeight)];
        _selectedView.backgroundColor = RGB(248, 248, 248);
    }
    return _selectedView;
}

-(UITableView *)listView
{
    if (!_listView) {
        _listView = [[UITableView alloc]init];
        _listView.frame = CGRectMake(0, self.selectedView.bottom, self.maskView.frame.size.width , listViewHeight);
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_listView registerClass:[MMChooseAddressCell class] forCellReuseIdentifier:@"MMChooseAddressCell"];
        _listView.backgroundColor = RGB(248, 248, 248);
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 15.0, *)) {
            _listView.sectionHeaderTopPadding = 0;
        }
    }
    return _listView;
}





-(NSMutableArray *)allAddressArr{
    if(!_allAddressArr){
        _allAddressArr = [NSMutableArray array];
    }
    return _allAddressArr;
}

-(NSMutableArray *)selectedAddressArr{
    if(!_selectedAddressArr){
        _selectedAddressArr = [NSMutableArray array];
    }
    return _selectedAddressArr;
}

-(NSMutableArray *)currentListArr{
    if(!_currentListArr){
        _currentListArr = [NSMutableArray array];
    }
    return _currentListArr;
}


#pragma mark--列表代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    sectionHeaderView.backgroundColor = RGB(248, 248, 248);
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 200, 40)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = MM_kBoldFont(15);
    titleLab.textColor = RGB(51, 51, 51);

    NSString *text = @"";
    if(self.selectedAddressArr.count == 1 || self.selectedAddressArr.count == 0 ){
        text = @"选择省份/地区";
    }else if(self.selectedAddressArr.count == 2){
        text = @"选择城市";
    }else if(self.selectedAddressArr.count == 3){
        text = @"选择区县";
    }else{
        text = @"选择街道/镇";
    }
    titleLab.text = text;
    [sectionHeaderView addSubview:titleLab];
    return sectionHeaderView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 38;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMAddressDataModel *model = self.currentListArr[indexPath.row];
    MMChooseAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMChooseAddressCell" forIndexPath:indexPath];
    cell.model = model;
    [cell configureCellWithIndexPath:indexPath andTableView:tableView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MMAddressDataModel *model = self.currentListArr[indexPath.row];
  
    //先移除selectedAddressArr里的空model（”请选择...“）
    for (MMAddressDataModel *selectedModel in self.selectedAddressArr) {
        if(MM_SafeStr(selectedModel.code).length == 0){
            [self.selectedAddressArr removeObject:selectedModel];
        }
    }
        
    
    //selectedAddressArr是否包含当前level 如果包含level 则证明是往回点击 示例selectedAddressArr 有 A level = 1，B level = 2，C level = 3  ,点击列表后选择的model level = 2 则当前model替换B 后面的移除
    if([self selectedAddressArrHasModelLevel:model] == YES){
        
        DLog(@"selectedAddressArr 包含 当前点击的列表model level");
        NSMutableArray *tempArr = [NSMutableArray array];
        for(int i = 0; i < self.selectedAddressArr.count ; i ++){
            MMAddressDataModel *tempModel = self.selectedAddressArr[i];
            if([MM_SafeStr(tempModel.level) isEqualToString:MM_SafeStr(model.level)]){
                //因为是有序的所以到相等的这里直接break;
                break;
            }
            [tempArr addObject:tempModel];

        }
        
        //添加当前model 到tempArr
        [tempArr addObject:model];
        
        //移除所有的selectedAddressArr
        [self.selectedAddressArr removeAllObjects];
        //添加tempArr 到 selectedAddressArr
        [self.selectedAddressArr addObjectsFromArray:tempArr];
    }else{
        //添加列表选中的model到selectedAddressArr
        [self.selectedAddressArr addObject:model];
    }
 
    
    
    
    //判断是否是最后一级
    if(model.children.count > 0){
        [self.currentListArr removeAllObjects];
        [self.currentListArr addObjectsFromArray:model.children];
        
        DLog(@"还有下一级地区数据，给selectedAddressArr 后面增加一个空的model");
        
        
        //增加空model
        MMAddressDataModel *lastModel = self.selectedAddressArr.lastObject;
        
        MMAddressDataModel *addModel = [[MMAddressDataModel alloc]init];
        addModel.level = [NSString stringWithFormat:@"%d",(lastModel.level.intValue + 1)];
        [self.selectedAddressArr addObject:addModel];


    }else{
        DLog(@"无下级地区数据  是最后一级");
        
        //回调出选中的结果代理方法
        if(self.delegate && [self.delegate respondsToSelector:@selector(mmChooseAddressViewDidSelectedArr:)]){
            [self.delegate mmChooseAddressViewDidSelectedArr:self.selectedAddressArr];
        }
        
        [self dissMiss];
    }
    
    
    //将selectedAddressArr 最后一个元素置为高亮
    for(int i = 0 ; i < self.selectedAddressArr.count ; i++){
        MMAddressDataModel *selectedModel = self.selectedAddressArr[i];
        if(i == (self.selectedAddressArr.count - 1)){
            selectedModel.selected = YES;
        }else{
            selectedModel.selected = NO;
        }
    }
    
    
    //刷新
    [self reloadUI];
    
}
#pragma mark-----MMAddressSelectedView 已选择view 点击代理-----
-(void)mmAddressSelectedViewDidTouch:(MMAddressDataModel *)model{
    
    
    //让当前点击的高亮
    for (MMAddressDataModel *m in self.selectedAddressArr) {
        if([MM_SafeStr(m.code) isEqualToString:MM_SafeStr(model.code)]){
            m.selected = YES;
        }else{
            m.selected = NO;
        }
    }
    
    
    //点击的是最后一个空model  直接刷新列表即可
    if(MM_SafeStr(model.code).length == 0){
        [self.listView reloadData];
    }else{

        
        //根据点击的model 找到 点击model 所在的那一层数组
        NSArray *touchArr = [self findArrayWithCode:model.code inArray:self.allAddressArr];
        if(touchArr){
            //更新下半部分的当前列表currentListArr 数据
            [self.currentListArr removeAllObjects];
            [self.currentListArr addObjectsFromArray:touchArr];
        }
        
        [self reloadUI];
    }
    
    
    
}



#pragma mark-----action-----


//刷新整体UI
-(void)reloadUI{

    selectedViewHeight = self.selectedAddressArr.count * 40;
    listViewHeight = self.contentView.frame.size.height - self.topView.frame.size.height - selectedViewHeight;
    
    
    //如果没有已选的数据
    if(self.selectedAddressArr.count == 0){
        [self.currentListArr addObjectsFromArray:self.allAddressArr];
    }
    
//    self.selectedView = nil;
    //selectedView 移除所有子视图
    for (UIView *subview in  self.selectedView.subviews) {
        [subview removeFromSuperview];
    }
    self.selectedView.frame = CGRectMake(0, self.topView.bottom, self.maskView.frame.size.width, selectedViewHeight);
    
    for(int i = 0; i < self.selectedAddressArr.count ; i++){
        
        MMAddressDataModel *selectedModel = self.selectedAddressArr[i];
        MMAddressSelectedView *selectedItem= [[MMAddressSelectedView alloc]initWithFrame:CGRectMake(0, 40 * i, self.maskView.frame.size.width, 40)];
        selectedItem.delegate = self;
        selectedItem.model = selectedModel;
        [self.selectedView addSubview:selectedItem];
        
        //第0个隐藏上半部分
        if(i == 0){
            selectedItem.topLine.hidden = YES;
        }
        //最后一个隐藏最后一个
        if(i == (self.selectedAddressArr.count - 1)){
            selectedItem.bottomLine.hidden = YES;
        }
        
    }
    
    self.listView.frame = CGRectMake(0, self.selectedView.bottom, self.maskView.frame.size.width , listViewHeight);

    //排序
    [self sortCurrentList];
    [self.listView reloadData];
    
}


/*
 从外部传入 code 集合  逗号间隔 code1,code2,code3
 */
-(void)setCodesString:(NSString *)codes{
    
    //转为数组
    NSArray *codeArray = [codes componentsSeparatedByString:@","];
    
    //移除所有的选中的
    [self.selectedAddressArr removeAllObjects];
    for (NSString *code in codeArray) {
       
        MMAddressDataModel *model = [self findModelWithCode:code inArray:self.allAddressArr];
        model.selected = NO;
        [self.selectedAddressArr addObject:model];
        
    }
    
    
     //移除当前列表的数据
     [self.currentListArr removeAllObjects];
    
    MMAddressDataModel *last_model = self.selectedAddressArr.lastObject;
    if(last_model.children.count > 0){
        DLog(@"说明传入的地址最后一个还有下一级");
        
        //找到当前code的下一级数据作为列表数组
        [self.currentListArr addObjectsFromArray:last_model.children];

        //增加空model
        MMAddressDataModel *lastModel = self.selectedAddressArr.lastObject;
        
        MMAddressDataModel *addModel = [[MMAddressDataModel alloc]init];
        addModel.level = [NSString stringWithFormat:@"%d",(lastModel.level.intValue + 1)];
        [self.selectedAddressArr addObject:addModel];
        
    }else{
        DLog(@"说明传入的地址最后一个没有下一级");
        //找到最后一个code所在的列表数据
        NSArray *c_arr = [self findArrayWithCode:last_model.code inArray:self.allAddressArr];
        if(c_arr){
            [self.currentListArr addObjectsFromArray:c_arr];
        }
        
    }
    
    //将最后一个置为选中
    MMAddressDataModel *new_last_model = self.selectedAddressArr.lastObject;
    new_last_model.selected = YES;
    
    [self reloadUI];
    
}
-(void)cancelBtnClick:(UIButton *)sender{
    
    [self dissMiss];
}

-(void)show{
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    UIWindowScene *currentWindowScene = [UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    UIWindow *currentWindow = currentWindowScene.windows.firstObject;
    [currentWindow addSubview:self];
}

-(void)dissMiss{
    [self removeFromSuperview];
}


#pragma mark------------算法------------
/*
 根据code 查找 该code所在的那一层 数组 这里因为是多维数组  所以采用递归
 */
- (NSArray<MMAddressDataModel *> *)findArrayWithCode:(NSString *)code inArray:(NSArray<MMAddressDataModel *> *)array {
    for (MMAddressDataModel *model in array) {
        if ([model.code isEqualToString:code]) {
            return array;
        }
        
        if (model.children.count > 0) {
            //如果上一级没找到接着调用自己
            NSArray *result = [self findArrayWithCode:code inArray:model.children];
            if (result) {
                return result;
            }
        }
    }
    return nil;
}


/*
 根据code 查找 该code的model  这里因为是多维数组  所以采用递归
 */
- (MMAddressDataModel *)findModelWithCode:(NSString *)code inArray:(NSArray<MMAddressDataModel *> *)array {
    for (MMAddressDataModel *model in array) {
        if ([model.code isEqualToString:code]) {
            return model;
        }
        
        if (model.children.count > 0) {
            //如果上一级没找到接着调用自己
           MMAddressDataModel *result = [self findModelWithCode:code inArray:model.children];
            if (result) {
                return result;
            }
        }
    }
    return nil;
}

//判断是否包含当前level
-(BOOL)selectedAddressArrHasModelLevel:(MMAddressDataModel *)model {
    
    for (MMAddressDataModel *m in self.selectedAddressArr) {
        
        if([m.level isEqualToString:model.level]){
            return YES;
        }
    }
    
    return NO;
}

/*
 排序并获得首字母
 */
-(void)sortCurrentList{
    
    
    // 排序数据
    [self.currentListArr sortUsingComparator:^NSComparisonResult(MMAddressDataModel *model1, MMAddressDataModel *model2) {
        NSString *name1 = model1.name;
        NSString *name2 = model2.name;
        NSString *firstChar1 = [name1 substringToIndex:1];
        NSString *firstChar2 = [name2 substringToIndex:1];
        
        NSString *pinyinFirstLetter1 = [NSString pinyinFirstLetterFromChinese:firstChar1];
        NSString *pinyinFirstLetter2 = [NSString pinyinFirstLetterFromChinese:firstChar2];
        
        
//        DLog(@"name1 = %@,firstChar1 = %@,pinyinFirstLetter1 = %@",name1,firstChar1,pinyinFirstLetter1);
//        DLog(@"name2 = %@,firstChar2 = %@,pinyinFirstLetter2 = %@",name1,firstChar1,pinyinFirstLetter1);

        return [pinyinFirstLetter1 compare:pinyinFirstLetter2 options:NSCaseInsensitiveSearch];
    }];
    
    
    // 用于保存已赋值首字母的字典
    NSMutableDictionary *firstLetterDict = [NSMutableDictionary dictionary];

    // 遍历数组，补充 firstLetter 字段
    for (MMAddressDataModel *model in self.currentListArr) {
        NSString *name = model.name;
        NSString *firstChar = [name substringToIndex:1];
        NSString *pinyinFirstLetter = [NSString pinyinFirstLetterFromChinese:firstChar];
        NSString *uppercaseFirstLetter = [pinyinFirstLetter uppercaseString]; // 转为大写
        
        // 如果该首字母还未赋值给其他模型，则赋值给当前模型的 firstLetter
        if (!firstLetterDict[uppercaseFirstLetter]) {
            model.firstLetter = uppercaseFirstLetter;
            firstLetterDict[uppercaseFirstLetter] = @(YES);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
