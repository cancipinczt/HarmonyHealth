
import router from '@ohos.router'
import { AIChatDir } from '../../../data/AiRequest'
import { getFoodsList } from '../../../data/FoodRequest'
import { getSportsList } from '../../../data/SportRequest'
import { AIAnswer } from '../../../data/User'
import { AIChat } from '../../../data/UserRequest'
class ChartItemInfo {
  content: string
  isUser: boolean
}


@Component
struct CharListItem {
  charItemInfo: ChartItemInfo

  build() {
    Column() {
      Row() {
        if (this.charItemInfo.isUser == true) {
          Text(this.charItemInfo.content)
            .margin({right: "5%"})
            .fontSize(20)
            .backgroundColor(Color.Pink)
            .width("70%")
            .padding("2%")
            .borderRadius(10)
          Image($r('app.media.ic_user_photo'))
            .width("10%")
            .borderRadius(100)
            .backgroundColor(Color.Black)

        }
        else {
          Image($r('app.media.logo'))
            .width("10%")
            .borderRadius(100)
            .backgroundColor(Color.Black)
          Text(this.charItemInfo.content)
            .margin({left: "5%"})
            .fontSize(20)
            .backgroundColor(Color.Pink)
            .width("70%")
            .padding("2%")
            .borderRadius(10)
        }
      }
      .width("100%")
      .padding("5%")
      .alignItems(VerticalAlign.Top)
      .justifyContent(this.charItemInfo.isUser ? FlexAlign.End : FlexAlign.Start)
    }
    .width("100%")
  }
}


@Component
struct ChartList {

  charInfo : ChartItemInfo[]
  
  build() {
    Scroll() {
      Column() {
        ForEach(this.charInfo, (item: ChartItemInfo) => {
          CharListItem({charItemInfo: item})
        })
      }
    }
    .scrollable(ScrollDirection.Vertical)
  }
}


@Entry
@Component
struct AiAssistant {

  tmpQues: string = ""

  @State refresh: boolean = true

  scroller: Scroller = new Scroller()
  charInfo : ChartItemInfo[] = [
    {content: "AI助手", isUser: false},
  ]

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width("10%")
          .margin({left: "5%", right: "5%"})
          .onClick(() => {
            router.back()
          })
        Text('AI助手')
          .fontSize(30)
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.Start)

      Column() {

        Scroll(this.scroller) {
          Column(){
            if (this.refresh == true) {
              ChartList({charInfo: this.charInfo})
            }
            else {
              ChartList({charInfo: this.charInfo})
            }
          }
          .height("100%")
        }
        .scrollable(ScrollDirection.Vertical)
        .height("80%")

        Row() {
          if (this.refresh) {
            TextInput()
              .width("70%")
              .onChange((value) => {
                this.tmpQues = value
              })
          }
          else {
            TextInput()
              .width("70%")
              .onChange((value) => {
                this.tmpQues = value
              })
          }

          Text("发送")
            .fontSize(20)
            .backgroundColor(Color.Pink)
            .padding("2%")
            .borderRadius(10)
            .onClick(() => {
              this.charInfo.push({content: this.tmpQues, isUser: true})
              AIChat(this.tmpQues).then(res => {
                let ans: AIAnswer = JSON.parse(JSON.parse(res as string))
                console.info("AIChartResult:" + ans.chatId)
                this.charInfo.push({content: ans.answer, isUser: false})
                AppStorage.Set("chartId", ans.chatId)
                this.refresh = !this.refresh
                this.scroller.scrollEdge(Edge.Bottom)
              })

              // AIChatDir(this.tmpQues).then(res => {
              //   console.info("AIChartResult:" + res)
              //   let ans = JSON.parse(JSON.parse(res as string))
              //   console.info("AIChartResult:" + ans.choices[0].message.content)
              //   this.charInfo.push({content: ans.choices[0].message.content, isUser: false})
              //   this.refresh = !this.refresh
              //   this.scroller.scrollEdge(Edge.Bottom)
              // })
              this.refresh = !this.refresh
              this.scroller.scrollEdge(Edge.Bottom)
            })
        }
        .width("100%")
        .height("10%")
        .justifyContent(FlexAlign.SpaceEvenly)
      }
    }
  }
}