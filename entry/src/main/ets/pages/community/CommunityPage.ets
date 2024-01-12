
import { AllContent } from './AllContentPage'
import { FocusContent } from './FocusContentPage'

@Entry
@Component
export struct CommunityPage {
  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          AllContent()
        }.tabBar("全部")

        TabContent() {
          FocusContent()
        }.tabBar("关注")
      }
      .backgroundColor("#B8FFBC")
    }
  }
}