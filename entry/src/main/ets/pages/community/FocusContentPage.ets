
import thermal from '@ohos.thermal'
class Content {
  user_photo: Resource
  user_name: string
  user_content: string
}

class FrequentUser {
  user_photo: Resource
  user_name: string
}

@Component
struct ContentListItem {
  content: Content

  build() {
    Column() {
      Row() {
        Image(this.content.user_photo)
          .height("100%")
          .borderRadius(100)
          .margin({left: "2%"})
          .backgroundColor(Color.Black)

        Column() {
          Text(this.content.user_name)
            .fontSize(20)
            .fontColor(Color.Red)
            .width("100%")

          Text("13分钟前")
            .fontColor(Color.Gray)
            .width("100%")
        }
        .width("60%")
        .margin({left: "4%"})
      }
      .width("100%")
      .height("7%")
      .padding("2%")

      Column() {
        Text(this.content.user_content)
          .fontSize(100)
      }

      Flex({
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.SpaceEvenly,
        alignItems: ItemAlign.Center
      }) {
        Row() {
          Image($r('app.media.ic_share'))
            .height("70%")
          Text("转发")
            .margin({left: "2%"})
        }

        Row() {
          Image($r('app.media.ic_review'))
            .height("70%")
          Text("评论")
            .margin({left: "2%"})
        }

        Row() {
          Image($r('app.media.ic_like'))
            .height("70%")
          Text("233")
            .margin({left: "2%"})
        }
      }
      .width("100%")
      .height("5%")
    }
    .width("100%")
    .backgroundColor('rgba(255, 255, 255, 0.5)')
  }
}

@Component
struct FrequentListItem {
  frequent: FrequentUser

  build() {
    Column() {
      Image(this.frequent.user_photo)
        .width("15%")
        .borderRadius(100)
        .backgroundColor(Color.Black)
      Text(this.frequent.user_name)
    }
  }
}

@Entry
@Component
export struct FocusContent {

  contents: Content[] = [
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户1", user_content: "*************"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户2", user_content: "*************"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户3", user_content: "*************"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户4", user_content: "*************"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户5", user_content: "*************"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户6", user_content: "*************"}
  ]

  frequentUsers: FrequentUser[] = [
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户1"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户2"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户3"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户4"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户5"},
    {user_photo: $r('app.media.ic_user_photo'), user_name: "用户6"}
  ]

  build() {
    Column() {
      List({space: 20}) {

        ListItem() {
          Row() {
            Text("最常访问")
              .fontSize(20)
              .width("40%")

            Row().width("10%")

            Text("更多")
              .textAlign(TextAlign.End)
              .width("40%")


            Image($r('app.media.ic_forward'))
              .width("5%")
              .margin({right: "5%"})
          }
        }
        .margin({top: "5%", left: "5%" })

        ListItem() {
          List({space: 20}) {
            ForEach(this.frequentUsers, (frequentUser: FrequentUser) => {
              ListItem() {
                FrequentListItem({frequent: frequentUser})
              }
            })
          }
          .listDirection(Axis.Horizontal)
          .width("100%")
        }
        .margin({left: "5%"})

        ForEach(this.contents, (content: Content) => {
          ListItem() {
            ContentListItem({content: content})
          }
        })
      }
      .width("100%")
      .height("100%")
    }
    .backgroundColor("#B8FFBC")

  }
}