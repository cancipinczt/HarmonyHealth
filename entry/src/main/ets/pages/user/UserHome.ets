
import router from '@ohos.router'

@Entry
@Component
struct UserHome {

  @State currentTabIndex: number = 0

  @Builder
  tabBarItemBuilder(name: string, index: number) {
    Column() {
      Text(name)
        .fontColor(this.currentTabIndex === index ? Color.Pink : Color.Gray)
        .fontSize(20)
        .textAlign(TextAlign.Center)

      Divider()
        .vertical(false)
        .width("80%")
        .margin("10%")
        .color(this.currentTabIndex === index ? Color.Pink : Color.Transparent)
        .strokeWidth(4)

    }


  }

  build() {
    Column() {
      Stack() {

        Column() {
          Row() {
            Image($r('app.media.user_home_background'))
          }
          .height("60%")
          .width("100%")


          Column() {
            Row() {
              Column() {
                Text("2").fontSize(20).margin("10%")
                Text("粉丝")
              }
              .width("30%")

              Divider().vertical(true).margin("5%").height("80%")

              Column() {
                Text("69").fontSize(20).margin("10%")
                Text("关注")
              }
              .width("30%")

              Divider().vertical(true).margin("5%").height("80%")

              Column() {
                Text("3").fontSize(20).margin("10%")
                Text("获赞")
              }
              .width("30%")
            }


            Row() {
              Text("编辑资料")
                .fontSize(20)
                .fontColor(Color.Red)
                .width("100%")
                .textAlign(TextAlign.Center)
            }
            .height("80%")
            .width("120%")
            .margin({top: "10%", left: "20%"})
            .borderColor(Color.Red)
            .borderWidth(2)
            .borderRadius(5)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/user/UserInfoEdit',
                params: {
                  name: "无",
                  info: ""
                }
              })
            })

          }
          .height("10%")
          .width("50%")
          .margin({left: "50%", top: "5%"})

          Row() {
            Text("用户名123456")
              .fontSize(24)
              .fontColor(Color.Red)
          }
          .height("10%")
          .width("100%")
          .margin({top: "15%", left: "5%"})

          Row() {
            Text("这个人很神秘，什么都没有写")
              .fontSize(12)
              .fontColor(Color.Gray)
              .width("90%")
            Text("详情")
              .fontSize(12)
              .fontColor(Color.Blue)
              .width("10%")
          }
          .width("100%")
          .margin({left: "5%", top: "3%"})
        }
        .height("100%")

        Column() {
          Image($r('app.media.ic_user_photo'))
            .width("100%")
            .borderRadius(100)
            .backgroundColor(Color.Blue)
        }
        .width("25%")
        .margin({left: "5%", top: "30%", right: "950%"})

        Row() {
          Column() {
            Image($r('app.media.ic_top_back'))
              .height("100%")
              .backgroundColor('rgba(0,0,0,0.6)')
              .borderRadius(100)
          }
          .width("10%")
          .margin({left: "2%"})
          .onClick(() => {
            router.back()
          })

          Column() {}.width("60%")

          Column() {
            Image($r('app.media.ic_top_search'))
              .height("100%")
              .backgroundColor('rgba(0,0,0,0.6)')
              .borderRadius(100)
          }
          .width("10%")

          Column() {
            Image($r('app.media.ic_top_more'))
              .height("100%")
              .backgroundColor('rgba(0,0,0,0.6)')
              .borderRadius(100)
          }
          .width("10%")
          .margin({left: "5%"})

        }
        .height("10%")
        .width("100%")
        .margin({top: "5%", bottom: "90%"})

      }
      .height("50%")
      .width("100%")

      Divider().vertical(false).width("100%").margin({top: "5%"})

      Column() {
        Tabs({barPosition: BarPosition.Start}) {
          TabContent() {
            Text("主页")
          }.tabBar(this.tabBarItemBuilder("主页", 0))

          TabContent() {
            Text("动态")
          }.tabBar(this.tabBarItemBuilder("动态", 1))

          TabContent() {
            Text("投稿")
          }.tabBar(this.tabBarItemBuilder("投稿", 2))

          TabContent() {
            Text("收藏")
          }.tabBar(this.tabBarItemBuilder("收藏", 3))
        }
        .onChange((index) => {
          this.currentTabIndex = index
        })
      }
      .height("50%")
      .width("100%")
    }
    .height("100%")
    .width("100%")
  }
}