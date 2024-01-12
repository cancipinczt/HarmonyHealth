
import router from '@ohos.router'
import { UserInfo } from '../../data/User'
import { getUserInfo, updateUserInfo } from '../../data/UserRequest'
@Component
struct InfoListItem {
  name: string
  @Prop info: string

  build() {
    Row() {
      Text(this.name)
        .width("20%")
      Text(this.info)
        .width("70%")
        .fontColor('rgba(0, 0, 0, 0.6)')
        .textAlign(TextAlign.End)
      Image($r('app.media.ic_forward')).width("5%").margin({left: "5%"})
    }
    .margin("5%")
  }
}


// class UserInfo {
//   user_photo: Resource
//   user_name: string
//   user_sex: string
//   user_birth: Date
//   personal_signature: string
//   phoneNumber: string
// }

@Entry
@Component
export struct UserInfoEdit {

  @State paramName: string = router.getParams()['name']
  @State info: string = router.getParams()['info']

  @State isLunar: boolean = false
  @State userInfo: UserInfo = new UserInfo()

  @State name: string = this.userInfo.userName

  @State birth: string = this.userInfo.birth

  @State sex: string = this.userInfo.gender

  @State signature: string = this.userInfo.signature

  @State phoneNumber: string = this.userInfo.phoneNumber

  @State loading: boolean = true

  aboutToAppear() {
  }

  aboutToDisappear() {
    updateUserInfo(this.name, this.phoneNumber, this.sex, this.birth, this.signature, this.userInfo.photo)
  }

  onPageShow() {

    getUserInfo().then(res => {
      console.info("getUserInfo" + res)
      this.userInfo = new UserInfo()
      this.userInfo = JSON.parse(JSON.parse(res as string))

      console.info("getUserInfo" + this.userInfo)
      this.paramName = router.getParams()['name']
      this.info = router.getParams()['info']
      this.userInfo.userName = this.paramName == "昵称" ? this.info : this.userInfo.userName
      this.userInfo.signature = this.paramName == "个性签名" ? this.info : this.userInfo.signature
      this.userInfo.phoneNumber = this.paramName == "电话号码" ? this.info : this.userInfo.phoneNumber

      console.info("getUserInfo" + this.userInfo)
      this.name = this.userInfo.userName
      this.signature = this.userInfo.signature
      this.phoneNumber = this.userInfo.phoneNumber
      this.birth = this.userInfo.birth
      this.sex = this.userInfo.gender

      console.info("getUserInfo" + this.userInfo)
      this.loading = false
    })

  }


  build() {
    if (this.loading == true) {
      Text('加载中').fontSize(24)
    }
    else {
      Column() {
        Row() {
          Image($r('app.media.ic_top_back'))
            .height("60%")
            .onClick(() => {
              updateUserInfo(this.name, this.phoneNumber, this.sex, this.birth, this.signature, this.userInfo.photo)
              router.back()
            })
          Text("账号资料").fontSize(24).fontColor(Color.White)
        }
        .height("10%")
        .width("100%")
        .backgroundColor(Color.Pink)


        List() {
          ListItem() {
            Row() {
              Text("头像").width("20%")
              Row().width("50%")
              Image(this.userInfo.photo)
                .width("20%")
                .borderRadius(100).backgroundColor(Color.Black)
              Image($r('app.media.ic_forward'))
                .width("5%").margin({left: "5%"})
            }
            .margin("5%")
          }.backgroundColor(Color.White)

          ListItem() {
            InfoListItem({name: "昵称", info: this.name})
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            updateUserInfo(this.userInfo.userName, this.userInfo.phoneNumber, this.userInfo.gender, this.birth, this.signature, "")
            router.pushUrl({url: "pages/user/UserNameEdit"})
          })

          ListItem() {
            InfoListItem({name: "性别", info: this.sex})
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            ActionSheet.show({
              title: '请选择性别',
              message: '',
              confirm: {
                value: '确定',
                action: () => {
                  console.log('Get Alert Dialog handled')
                }
              },
              alignment: DialogAlignment.Center,
              sheets: [
                {
                  title: '男 ♂',
                  action: () => {
                    this.userInfo.gender = "男"
                    this.sex = this.userInfo.gender
                  }
                },
                {
                  title: '女 ♀',
                  action: () => {
                    this.userInfo.gender = "女"
                    this.sex = this.userInfo.gender
                  }
                },
                {
                  title: '保密 ?',
                  action: () => {
                    this.userInfo.gender = "保密"
                    this.sex = this.userInfo.gender
                  }
                }
              ]
            })
          })

          ListItem() {
            InfoListItem({name: "出生年月", info: this.birth})
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-1-1"),
              selected: new Date(this.userInfo.birth),
              lunar: this.isLunar,
              onAccept: (value: DatePickerResult) => {
                this.userInfo.birth = value.year + "-" + (value.month + 1) + "-" + value.day
                this.birth = this.userInfo.birth
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
              onChange: (value: DatePickerResult) => {
                console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })


          ListItem() {
            InfoListItem({name: "个性签名", info: this.signature})
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({url: "pages/user/UserSignatureEdit"})
          })

          ListItem() {
            InfoListItem({name: "电话号码", info: this.phoneNumber})
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({url: "pages/user/UserPhoneEdit"})
          })


        }
        .divider({
          strokeWidth: 1,
          color: 'rgba(0, 0, 0, 0)',
        })
        .height("100%")
        .width("100%")
        .backgroundColor('rgba(0, 0, 0, 0.05)')
        .padding({top: "5%"})
      }
      .height("100%")
      .width("100%")
    }

  }
}
