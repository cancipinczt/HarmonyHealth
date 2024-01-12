export class RecordDietItemData {
  id: number
  foodName: string
  image: string
  grams: number
  totalKcal: number
  meal: string
}

export class RecordDietDetailData {
  id : number
  foodName: string
  image: string
  grams: number
  meal: string
  totalKcal: number
  totalCarbs: number
  totalFat: number
  totalFibre: number
  totalProtein: number
}

export class RecordSportItemData {
  id: number
  sportName: string
  image: string
  minutes: number
  totalEnergy: number
}

export class RecordHealthStateData {
  inKcal: number// 摄入热量
  outKcal: number// 消耗热量
  fat: number// 摄入脂肪/g
  fibre: number// 摄入纤维/g
  carbs: number// 摄入碳水化合物/g
  protein: number// 摄入碳水化合物/g
}
