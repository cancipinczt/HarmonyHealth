

export class UserInfo {
  userName: string//用户名
  phoneNumber: string//手机号
  gender: string//性别
  birth: string//出生年月
  signature: string//个性签名
  photo: string//头像
}

export class UserWeightGoal {
  goalWeight: number
  currWeight: number
  startWeight: number
  startDate: string
  endDate: string
}

export class LoginResponse {
  userId: number
  permission: boolean
}

export class RegisterResponse {
  permission: boolean
}

export class AIAnswer {
  chatId: number
  answer: string
}