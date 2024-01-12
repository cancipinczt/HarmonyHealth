/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import router from '@ohos.router'
import curves from '@ohos.curves'
import { BreakpointSystem, BreakPointType } from '../common/BreakpointSystem'
import { HomePage } from './home/HomePage'
import { UserPage } from './user/UserPage'
import { SportPage } from './sport/SportPage'
import { FoodPage } from './food/FoodPage'
import { CommunityPage } from './community/CommunityPage'


@Entry
@Component
struct Home {
  @State currentTabIndex: number = 0
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @State refresh: boolean = true

  @Builder
  bottomBarItemBuilder(name: Resource, icon: Resource, index: number) {
    Flex({
      direction: new BreakPointType({
        sm: FlexDirection.Column,
        md: FlexDirection.Row,
        lg: FlexDirection.Column
      }).getValue(this.currentBreakpoint),
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Image(icon)
        .height(24)
        .width(24)
        .fillColor(this.getTabBarColor(index))
      Text(name)
        .margin(new BreakPointType<Padding>({
          sm: { top: 4 },
          md: { left: 8 },
          lg: { top: 4 }
        }).getValue(this.currentBreakpoint) as Padding)
        .fontSize(11)
        .fontColor(this.getTabBarColor(index))
    }
  }

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  build() {


    Tabs({
      barPosition: new BreakPointType({
        sm: BarPosition.End,
        md: BarPosition.End,
        lg: BarPosition.Start
      }).getValue(this.currentBreakpoint)
    }) {
      TabContent() {
        if (this.refresh) {
          HomePage()
        } else {
          HomePage()
        }
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_home"), $r("app.media.ic_bottom_home"), 0))

      TabContent() {
        CommunityPage()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_community"), $r("app.media.ic_bottom_diet"), 1))

      TabContent() {
        FoodPage()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_diet"), $r("app.media.ic_bottom_diet"), 2))

      TabContent() {
        SportPage()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_sport"), $r("app.media.ic_bottom_sport"), 3))

      TabContent() {
        UserPage()
      }.tabBar(this.bottomBarItemBuilder($r("app.string.tab_bar_user"), $r("app.media.ic_bottom_user"), 4))


    }
    .vertical(new BreakPointType({ sm: false, md: false, lg: true }).getValue(this.currentBreakpoint) as boolean)
    .barWidth(new BreakPointType({ sm: '100%', md: '100%', lg: '56vp' }).getValue(this.currentBreakpoint) as string)
    .barHeight(new BreakPointType({ sm: '10%', md: '10%', lg: '60%' }).getValue(this.currentBreakpoint) as string)
    .animationDuration(0)
    .onChange((index) => {
      this.refresh = !this.refresh
      this.currentTabIndex = index
    })
    .backgroundColor("#B8FFBC")
  }

  private getTabBarColor(index: number) {
    return this.currentTabIndex == index ? $r('app.color.tab_bar_select_color') : $r('app.color.tab_bar_normal_color')
  }
}