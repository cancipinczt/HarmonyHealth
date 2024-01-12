
import router from '@ohos.router'
import curves from '@ohos.curves'
import { BreakPointType } from '../../common/BreakpointSystem'
import { FoodCategory, FoodCategoryId, FoodDetailData, FoodItemData, getFoodCategories } from '../../data/Food'
import { getFoodDetail, getFoodsList, getFoodsListByCategory } from '../../data/FoodRequest'
import { createDiet } from '../../data/RecordRequest'

@Component
struct FoodListItem {
  private foodItem: FoodItemData = null

  foodDetail: FoodDetailData = null

  dialogController: CustomDialogController = new CustomDialogController({
    builder: FoodDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      foodInfo: this.foodDetail
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  aboutToDisappear() {
    this.dialogController = undefined // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }


  build() {
    Row() {
      Image('data:image/jpeg;base64,' + this.foodItem.image)
        .width("20%").margin({right: "2%"})

      Column() {
        Text(this.foodItem.name)
          .fontSize(20)
        Text(this.foodItem.kcal + "千卡/100克")
          .fontSize(12)
          .margin({top: "2%"})
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      .width("70%")

      Image($r('app.media.ic_forward'))
        .width("10%")
    }
    .width("100%")
    .onClick(() => {
      getFoodDetail(this.foodItem.name).then(res => {
        this.foodDetail = JSON.parse(JSON.parse(res as string))
        if (this.dialogController != undefined) {
          this.dialogController.open()
        }
      })

    })
  }
}

@Component
struct FoodList {
  private foodItems: FoodItemData[] = GetFoodsMock()
  categoryId: number = 0
  @State loading: boolean = true
  dialogController: CustomDialogController

  aboutToAppear() {
    console.info("FoodListInit1:" + this.categoryId)
    if (this.categoryId == 0) {
      getFoodsList().then(res => {
        let str = JSON.parse(res as string)
        let obj : FoodItemData[] = JSON.parse(str)
        this.foodItems = obj
        console.info("FoodListInit1:" + this.foodItems[0].name)
        console.info("FoodListInit1:" + this.categoryId)
        this.loading = false
      })
    }
    else {
      getFoodsListByCategory(this.categoryId)
        .then(res => {
        let str = JSON.parse(res as string)
        let obj : FoodItemData[] = JSON.parse(str)
        this.foodItems = obj
        console.info("FoodListInit1:" + this.foodItems[0].name)
        console.info("FoodListInit1:" + this.categoryId)
        this.loading = false
      })
    }

  }

  build() {
    if (this.loading == true) {
      Column() {
        Text("暂无数据")
          .fontSize(36)
          .fontColor('rgba(0, 0, 0, 0.5)')
      }
      .height("100%")
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    else {
      List({ space: 30 }) {
        ForEach(this.foodItems, (item: FoodItemData) => {
          ListItem() {
            FoodListItem({foodItem: item})
          }
        })

        ListItem() {
          Column() {
            Text("已经到底了")
              .fontSize(20)
              .fontColor(Color.Gray)
          }
          .width("100%")
          .justifyContent(FlexAlign.Center)
        }
      }
      .height("100%")
      .width("100%")
    }

  }
}


function GetFoodDetailMocks() : FoodDetailData {
  return {
    name: "牛奶",
    fibre: 66,
    protein: 66,
    fat: 66,
    carbs: 66,
    kcal: 66,
    image: ""
  }
}

@CustomDialog
export struct FoodDetailDialog {

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  foodName: string
  foodInfo: FoodDetailData = GetFoodDetailMocks()
  meal: string = "早餐"

  @State isKeyboard : boolean = false

  @State tmpGrams: number = 0

  build() {

    Column() {
      Row() {
        Select([
          {value:'早餐'},
          {value:'午餐'},
          {value:'晚餐'},
        ])
          .selected(2)
          .value(this.meal)
          .font({size: 24, weight:400, family: 'serif', style: FontStyle.Normal })
          .selectedOptionFont({size: 24, weight: 500, family: 'serif', style: FontStyle.Normal })
          .optionFont({size: 24, weight: 400, family: 'serif', style: FontStyle.Normal })
          .onSelect((index:number, value: string)=>{
            console.info("Select:" + index)
            this.meal = value
          })
      }
      .margin("5%")

      Column() {
        Image('data:image/jpeg;base64,' + this.foodInfo.image)
          .width(100)
          .height(100)
        Text(this.foodInfo.name)
      }

      Column() {
        Divider().vertical(false).strokeWidth(1).margin("2%")
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center
        }) {
          Column() {
            Text("热量")
            Text(this.foodInfo.kcal.toString())
          }

          Column() {
            Text("碳水")
            Text(this.foodInfo.carbs.toString())
          }

          Column() {
            Text("蛋白质")
            Text(this.foodInfo.protein.toString())
          }

          Column() {
            Text("脂肪")
            Text(this.foodInfo.fat.toString())
          }
        }
        Divider().vertical(false).strokeWidth(1).margin("2%")
      }
      .margin({top: "10%"})

      Row() {
        Column() {
          Text(this.isKeyboard == true ? "滑尺" : "键盘")
            .fontSize(20)
            .width("80%")
            .backgroundColor("#B8FFBC")
            .padding("5%")
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .onClick(() => {
              if (this.isKeyboard == false) {
                this.isKeyboard = true
              } else {
                this.isKeyboard = false
              }
            })
        }
        .width("30%")
        .justifyContent(FlexAlign.Center)

        Column() {
          if (this.isKeyboard == true) {
            TextInput({placeholder: "请输入数量"})
              .onChange((value: string) => {
                this.tmpGrams = parseInt(value)
              })
          } else {
            TextPicker({range: ['1', '2', '3', '4', '5', '6'], selected: 0})
              .onChange((value: string, index: number) => {
                this.tmpGrams = parseInt(value)
                console.info('Picker item changed, value: ' + value + ', index: ' + index)
              })
              .defaultPickerItemHeight("50%")
              .width("100%")
              .backgroundColor('rgba(255, 255, 255, 0.5)')
          }
        }
        .height("100%")
        .width("40%")
        .justifyContent(FlexAlign.Center)


        Text("百克")
          .fontSize(24)
          .width("30%")
          .textAlign(TextAlign.Center)
      }
      .height("30%")
      .width("100%")
      .alignItems(VerticalAlign.Center)

      Row() {
        Text("保存")
          .fontSize(24)
          .width("60%")
          .backgroundColor("#B8FFBC")
          .padding("2%")
          .textAlign(TextAlign.Center)
          .borderRadius(20)
          .onClick(() => {
            let date = new Date()
            let dateStr = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()
            createDiet(this.foodInfo.name, this.tmpGrams * 100, dateStr, this.meal)
            this.controller.close()
            this.confirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)

    }
    .height("80%")
    .width("100%")
    .backgroundColor('#ECFFEB')
  }

}

export function GetFoodsMock() : FoodItemData[] {
  return [
    {id: 1, name: "牛奶", kcal: 66, image: ""},
    {id: 1, name: "牛奶", kcal: 66, image: ""},
    {id: 1, name: "牛奶", kcal: 66, image: ""},
    {id: 1, name: "牛奶", kcal: 66, image: ""},
  ]
}


@Entry
@Component
export struct FoodPage {
  @State currentTabIndex: number = 0
  @State foodItems: FoodItemData[] = GetFoodsMock()
  @State refresh: boolean = true
  @State loading: boolean = true;
  private foodCategories: FoodCategory[] = getFoodCategories()


  @Builder
  tabBarItemBuilder(value: string, index: number) {
    Text(value)
      .fontColor(this.currentTabIndex === index ? 'rgba(0,0,0,0.9)' : 'rgba(0,0,0,0.4)')
      .fontSize(this.currentTabIndex === index ? 24 : 18)
      .width("100%")
      .height("15%")
      .backgroundColor(this.currentTabIndex == index ? '#ECFFEB' : '#B8FFBC')
      .textAlign(TextAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text("饮食")
          .fontSize(26).width("20%").textAlign(TextAlign.Center)

        Row() {
          Image($r('app.media.ic_search')).margin("2%").height("40%")
          Text("请输入食物名称")
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/food/FoodSearch' })
            .catch((err) => {
              console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
            })
        })
        .width("70%")
        .borderRadius(30)
        .margin("2%")
        .padding("2%")
        .backgroundColor("#EFEFEF")
      }
      .height("10%")
      .width("100%")


      Tabs({ barPosition: BarPosition.Start }) {
        // TabContent() {
        //   // FoodGrid({ foodItems: this.foodItems })
        //   FoodList({ categoryId: 0 })
        // }
        // .tabBar(this.tabBarItemBuilder('全部', 0))
        // .backgroundColor('#ECFFEB')

        ForEach(this.foodCategories, (foodCategory: FoodCategory, index?: number) => {
          TabContent() {
            FoodList({ categoryId: foodCategory.id })
          }
          .tabBar(this.tabBarItemBuilder(foodCategory.name!, index!))
          .backgroundColor('#ECFFEB')
        })
      }
      .animationDuration(0)
      .onChange((index) => {
        this.currentTabIndex = index
      })
      .barMode(BarMode.Scrollable)
      .barWidth("20%")
      .vertical(true)
      .margin({bottom: "20%"})
      .borderRadius(20)

    }
    .backgroundColor("#B8FFBC")
  }
}
