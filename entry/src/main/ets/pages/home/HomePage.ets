
import router from '@ohos.router'
import { UserWeightGoal } from '../../data/User'
import { getGoal } from '../../data/UserRequest'
@Component
struct SwiperItem {
  swiperInfo: SwiperInfo

  build() {
    Column() {
      Row() {
        Column() {
          Text("初始" + this.swiperInfo.category).width("100%").textAlign(TextAlign.Center)
          Text(this.swiperInfo.min.toString() + this.swiperInfo.unit).width("100%").textAlign(TextAlign.Center)
        }.width("20%")

        Stack() {
          Progress({ value: Math.abs(this.swiperInfo.current - this.swiperInfo.min), total: Math.abs(this.swiperInfo.max - this.swiperInfo.min), type: ProgressType.Ring }).height("80%")
            .style({ strokeWidth: 10 })
            .margin("5%")
          Column() {
            Text("当前" + this.swiperInfo.category).width("100%").textAlign(TextAlign.Center)
            Text(this.swiperInfo.current + this.swiperInfo.unit).width("100%").textAlign(TextAlign.Center)
          }
        }.width("50%")

        Column() {
          Text("目标" + this.swiperInfo.category).width("100%").textAlign(TextAlign.Center)
          Text(this.swiperInfo.max.toString() + this.swiperInfo.unit).width("100%").textAlign(TextAlign.Center)
        }.width("20%")
      }
    }
  }
}

@Component
struct RecordListItem {
  name: string
  data: string

  build() {
    Column() {
      Row() {
        Text(this.name)
          .fontSize(20)
          .margin("5%")
          .width("80%")
      }

      Row().height("25%")

      Row() {
        Text(this.data == null ? "没有记录" : this.data)
          .fontSize(12)
          .margin("5%")
          .width("80%")
          .fontColor(Color.Gray)
      }
    }
    .backgroundColor('rgba(255, 255, 255, 0.5)')
    .borderRadius(10)
    .width("90%")
    .height("15%")
    .margin("5%")
    .onClick(() => {
      router.pushUrl({ url: 'pages/food/DietRecord' })
        .catch((err) => {
          console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
        })
    })
  }
}


@Component
struct RecordCardListItem {
  name: string
  icon: Resource

  build() {
    Column() {
      Image(this.icon).height("60%")
      Text(this.name)
    }
    .width("20%")
  }
}


class SwiperInfo {
  min: number = 0
  max: number = 0
  current: number = 0
  category: string = ""
  unit: string = ""
}

@Entry
@Component
export struct HomePage {

  @State swiperInfo: SwiperInfo = new SwiperInfo()
  @State swiperLoading: boolean = true

  aboutToAppear() {
    this.swiperLoading = true
    getGoal().then(res => {
      let goalInfo: UserWeightGoal = JSON.parse(JSON.parse(res as string))
      this.swiperInfo = {min: 0, max: 0, current: 0, category: "体重", unit: "千克"}

      this.swiperInfo = {min: goalInfo.startWeight, max: goalInfo.goalWeight, current: goalInfo.currWeight, category: "体重", unit: "千克"}
      this.swiperLoading = false
    })
  }

  onPageShow() {
    this.swiperLoading = true

    getGoal().then(res => {
      let goalInfo: UserWeightGoal = JSON.parse(JSON.parse(res as string))
      console.info("updateGoal_1:" + goalInfo.currWeight)
      this.swiperInfo = {min: goalInfo.startWeight, max: goalInfo.goalWeight, current: goalInfo.currWeight, category: "体重", unit: "千克"}
      this.swiperLoading = false
    })
  }

  build() {
    Scroll() {
      Column() {
        Row() {
          Text("首页").fontSize(26)
        }.height("10%")

        if (this.swiperLoading == true) {
          Text("加载中").fontSize(24)
        }
        else {
          Swiper() {
            SwiperItem({swiperInfo: this.swiperInfo})
          }
          .height("20%")
          .borderRadius(10)
          .backgroundColor('rgba(255, 255, 255, 0.5)')
          .onClick(() => {
            router.pushUrl({url: "pages/user/userInfo/userWeightPage"})
          })
        }

        Column() {
          Row() {
            Column() {
              Text('饮食运动记录')
                .width("100%")
              Text('21:37更新')
                .width("100%")
                .fontSize(12)
                .margin({top: "5%"})
            }
            .width("45%")
            .margin("5%")


            Row(){
              Image($r('app.media.ic_user_photo'))
                .width("20%")
                .borderRadius(100)
                .margin({left: "5%" })
              Text('控卡食谱')
                .fontSize(20)
                .margin("5%")
            }
            .width("40%")
            .borderRadius(20)
            .border({
              width: 2
            })
          }
          .width("100%")

          Row() {
            Column() {
              Text("2033").width("100%").fontSize(24)
              Text("还可吃（千卡）").width("100%").margin({top: "5%"})
            }
            .width("40%")
            .margin({left: "5%" })

            Column() {
              Text("329").fontSize(20)
              Text("饮食").margin({top: "5%"})
            }
            .width("25%")
            .padding({top: "2%", bottom: "2%"})
            .backgroundColor('rgba(255, 255, 255, 0.5)')
            .borderRadius(10)

            Column() {
              Text("322").fontSize(20)
              Text("运动").margin({top: "5%"})
            }
            .width("25%")
            .margin({left: "2%"})
            .padding({top: "2%", bottom: "2%"})
            .backgroundColor('rgba(255, 255, 255, 0.5)')
            .borderRadius(10)
          }
          .width("100%")

          Progress({ value: 20, total: 100, type: ProgressType.Linear })
            .width("90%")
            .color(Color.Green)
            .margin("5%")

          List() {
            ListItem() {
              RecordCardListItem({name: "早餐", icon: $r('app.media.ic_bottom_record')})
            }

            ListItem() {
              RecordCardListItem({name: "午餐", icon: $r('app.media.ic_bottom_record')})
            }

            ListItem() {
              RecordCardListItem({name: "晚餐", icon: $r('app.media.ic_bottom_record')})
            }

            ListItem() {
              RecordCardListItem({name: "加餐", icon: $r('app.media.ic_bottom_record')})
            }

            ListItem() {
              RecordCardListItem({name: "运动", icon: $r('app.media.ic_bottom_record')})
            }
          }
          .listDirection(Axis.Horizontal)
          .width("100%")
          .height("10%")
        }
        .backgroundColor('rgba(255, 255, 255, 0.5)')
        .margin("5%")
        .borderRadius(20)
        .width("90%")
        .onClick(() => {
          router.pushUrl({ url: 'pages/record/RecordPage' })
            .catch((err) => {
              console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
            })
        })


        List() {
          ListItem() {
            RecordListItem({name: "体重记录" })
          }

          ListItem() {
            RecordListItem({name: "喝水记录" })
          }

          ListItem() {
            RecordListItem({name: "便便记录" })
          }

          ListItem() {
            RecordListItem({name: "睡眠记录" })
          }

          ListItem() {
            RecordListItem({name: "健康习惯" })
          }

          ListItem() {
            RecordListItem({name: "运动记录" })
          }

          ListItem() {
            RecordListItem({name: "饮食记录" })
          }

          ListItem() {
            RecordListItem({name: "饮食记录" })
          }
        }
        .lanes(2)
        .width("90%")
        .margin("5%")
      }
      .width("100%")

      Column().height("10%")
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .backgroundColor('rgba(0, 0, 0, 0.1)')
  }
}