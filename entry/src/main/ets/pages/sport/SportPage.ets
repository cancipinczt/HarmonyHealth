
import router from '@ohos.router'
import curves from '@ohos.curves'
import { BreakPointType } from '../../common/BreakpointSystem'
import { getSportCategories, SportCategory, SportCategoryId, SportDetailData, SportItemData } from '../../data/Sport'
import { getSportDetail, getSportsList, getSportsListByCategory } from '../../data/SportRequest'
import { createExercise } from '../../data/RecordRequest'
import TreeMap from '@ohos.util.TreeMap'
import { DateToString } from '../record/RecordPage'

@Component
struct SportListItem {
  private sportItem: SportItemData = null
  sportDetail: SportDetailData = null

  dialogController: CustomDialogController = new CustomDialogController({
    builder: SportDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      sportInfo: this.sportDetail
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
      Image('data:image/jpeg;base64,' + this.sportItem.image)
        .width("20%").height("10%").margin({right: "2%"})

      Column() {
        Text(this.sportItem.name)
          .fontSize(20)
        Text(this.sportItem.energy + "千卡/30分钟")
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
      getSportDetail(this.sportItem.name).then(res => {
        this.sportDetail = JSON.parse(JSON.parse(res as string))
        if (this.dialogController != undefined) {
          this.dialogController.open()
        }
      })

    })
  }
}

@Component
struct SportList {
  private sportItems: SportItemData[] = GetSportsMock()
  categoryId: number = 0
  @State loading: boolean = true
  dialogController: CustomDialogController

  aboutToAppear() {
    if (this.categoryId == 0) {
      getSportsList().then(res => {
        let str = JSON.parse(res as string)
        console.info("FoodListInit:" + str)
        let obj : SportItemData[] = JSON.parse(str)
        console.info("FoodListInit:" + obj)
        this.sportItems = obj
        console.info("FoodListInit:" + str)
        console.info("FoodListInit1:" + this.sportItems[0].name)
        this.loading = false
      })
    }
    else {
      getSportsListByCategory(this.categoryId)
        .then(res => {
          let str = JSON.parse(res as string)
          console.info("FoodListInit:" + str)
          let obj : SportItemData[] = JSON.parse(str)
          console.info("FoodListInit:" + obj)
          this.sportItems = obj
          console.info("FoodListInit:" + str)
          console.info("FoodListInit1:" + this.sportItems[0].name)
          this.loading = false
        })
    }
    console.info("FoodListInit1:" + this.sportItems[0].name)
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
        ForEach(this.sportItems, (item: SportItemData) => {
          ListItem() {
            SportListItem({sportItem: item})
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

export function GetSportDetailMock() : SportDetailData {
  return {
    name: "跑步",
    energy: 66,
    image: ""
  }
}

@CustomDialog
export struct SportDetailDialog {

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  sportName: string
  sportInfo: SportDetailData = GetSportDetailMock()
  tmpMin: number = 0

  @State isKeyboard : boolean = false

  build() {
    Column() {
      Row() {
        Text('运动')
      }
      .margin("5%")

      Column() {
        Image('data:image/jpeg;base64,' + this.sportInfo.image)
          .width("20%")
          .height("10%")
        Text(this.sportInfo.name)
      }

      Column() {
        Divider().vertical(false).strokeWidth(1).margin("2%")
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center
        }) {
          Column() {
            Text("能量")
            Text(this.sportInfo.energy.toString() + "千卡/60分钟")
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
                this.tmpMin = parseInt(value)
              })
          } else {
            TextPicker({range: ['1', '2', '3', '4', '5'], selected: 0})
              .onChange((value: string, index: number) => {
                this.tmpMin = parseInt(value)
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


        Text("30分钟")
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
            createExercise(this.sportInfo.name, this.tmpMin * 30, DateToString(new Date()))
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


export function GetSportsMock() : SportItemData[] {
  return [
    {name: "跑步", energy: 66, image: ''},
    {name: "跑步", energy: 66, image: ''},
    {name: "跑步", energy: 66, image: ''},
    {name: "跑步", energy: 66, image: ''},
  ]
}

@Entry
@Component
export struct SportPage {
  @State currentTabIndex: number = 0
  private sportItems: SportItemData[] = GetSportsMock()
  private sportCategories: SportCategory[] = getSportCategories()

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
        Text("运动")
          .fontSize(26).width("20%").textAlign(TextAlign.Center)

        Row() {
          Image($r('app.media.ic_search')).margin("2%").height("40%")
          Text("请输入运动名称")
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/sport/SportSearch' })
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

      Tabs() {
        // TabContent() {
        //   SportList({ categoryId: 0 })
        // }
        // .tabBar(this.tabBarItemBuilder('全部', 0))
        // .backgroundColor('#ECFFEB')

        ForEach(this.sportCategories, (sportCategory: SportCategory, index?: number) => {
          TabContent() {
            SportList({ categoryId: sportCategory.id })
          }
          .tabBar(this.tabBarItemBuilder(sportCategory.name!, index!))
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

