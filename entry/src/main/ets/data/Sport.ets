
export class SportItemData {
  name: string
  energy: number// 消耗能量（千卡/60分钟）
  image: string
}

export class SportDetailData {
  name: string
  energy: number// 消耗能量（千卡/60分钟）
  image: string
}

export enum SportCategoryId {
  walk = 1,
  running,
  riding,
  aerobics,
  DanceYoga,
  Swimming,
  PlayABallGame,
  StrengthTraining,
}

export class SportCategory {
  name: string | null = null;
  id: SportCategoryId | null = null;
}

export function getSportCategories() : SportCategory[] {
  return [
    {name: "走路", id: SportCategoryId.walk},
    {name: "跑步", id: SportCategoryId.running},
    {name: "骑行", id: SportCategoryId.riding},
    {name: "有氧操", id: SportCategoryId.aerobics},
    {name: "舞蹈瑜伽", id: SportCategoryId.DanceYoga},
    {name: "游泳", id: SportCategoryId.Swimming},
    {name: "打球", id: SportCategoryId.PlayABallGame},
    {name: "力量训练", id: SportCategoryId.StrengthTraining},
  ]
}