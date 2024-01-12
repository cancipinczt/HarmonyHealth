
import router from '@ohos.router'


@Entry
@Component
export struct UserPage {
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_user_photo'))
          .width("20%")
          .borderRadius(100)
          .backgroundColor(Color.Blue)

        Column() {
          Text("用户名").fontSize(20)
          Text("uid: 114514").fontSize(12).margin({top: "5%" })
        }
        .alignItems(HorizontalAlign.Start)
        .width("30%")
        .margin({left: "5%"})
        Row() {
          Text("个人主页").textAlign(TextAlign.End).width("90%")
          Image($r("app.media.ic_forward")).width("10%").margin({left: "5%"})
        }
        .width("45%")
        .onClick(() => {
          router.push({ url: 'pages/user/UserHome' })
        })

      }
      .height("10%")
      .width("100%")

      List({space: 30}) {

        ListItem() {
          Row() {
            Text("我的饮食运动记录").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

        ListItem() {
          Row() {
            Text("AI助手").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }
        .onClick(() => {
          router.pushUrl({url: "pages/user/userFeature/aiAssistant"})
        })

        ListItem() {
          Row() {
            Text("我的收藏").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

        ListItem() {
          Row() {
            Text("我的目标").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

        ListItem() {
          Row() {
            Text("本周食谱").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

        ListItem() {
          Row() {
            Text("数据统计").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

        ListItem() {
          Row() {
            Text("帮助与反馈").textAlign(TextAlign.Start).width("90%")
            Image($r("app.media.ic_forward")).width("5%").margin({left: "5%"})
          }
        }

      }
      .divider({
        strokeWidth: 1,
        startMargin: 0,
        endMargin: 0,
        color: Color.Gray
      })
      .height("90%")
      .width("100%")
      .backgroundColor("#ECFFEB")
      .borderRadius(10)
      .padding("5%")
      .margin({top: "10%"})
    }
    .alignItems(HorizontalAlign.Start)
    .alignSelf(ItemAlign.Start)
    .width("90%")
    .margin({top: "10%", bottom: "10%"})
  }

}

