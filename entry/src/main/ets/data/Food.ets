export class FoodItemData {
  id: number
  name: string
  kcal: number// 千卡/100g
  image: string
}

export class FoodDetailData {
  name: string
  fibre: number// 膳食纤维/100g
  protein: number// 蛋白质/100g
  fat: number// 脂肪/100g
  carbs: number// 碳水化合物/100g
  kcal: number// 千卡/100g
  image: string

  constructor(data: any) {
    this.name = data.name;
    this.fibre = data.fibre;
    this.protein = data.protein;
    this.fat = data.fat;
    this.carbs = data.carbs;
    this.kcal = data.kcal;
    this.image = data.image;
  }
}

export enum FoodCategoryId {
  DairyProductsAndEggs = 1,
  fruits,
  vegetables,
  candy,
  bakedGoodsAndGrains,
  meat,
  fish,
  beverages,
  readyToEatFlavors,
  finishedDishes
}

export class FoodCategory {
  name: string | null = null;
  id: FoodCategoryId | null = null;
}

export function getFoodCategories() : FoodCategory[] {
  return [
    {name: "乳制品和蛋类", id: FoodCategoryId.DairyProductsAndEggs},
    {name: "水果", id: FoodCategoryId.fruits},
    {name: "蔬菜", id: FoodCategoryId.vegetables},
    {name: "糖果", id: FoodCategoryId.candy},
    {name: "烘焙食品和谷物", id: FoodCategoryId.bakedGoodsAndGrains},
    {name: "肉类", id: FoodCategoryId.meat},
    {name: "鱼类", id: FoodCategoryId.fish},
    {name: "饮料", id: FoodCategoryId.beverages},
    {name: "即食风味品", id: FoodCategoryId.readyToEatFlavors},
    {name: "成品菜", id: FoodCategoryId.finishedDishes},
  ]
}