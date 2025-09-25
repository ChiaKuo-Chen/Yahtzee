
<img src="https://github.com/user-attachments/assets/7fd5cbfa-f469-40e7-9f8f-c167fde70ef7" width="200"/>
<img src="https://github.com/user-attachments/assets/af604d45-1773-4b69-9399-04f827ba6b98" width="200"/>

# Yahtzee 🎲 (SwiftUI)

這是一款使用 **SwiftUI** 開發的 Yahtzee 骰子遊戲。  
除了基本的遊戲規則外，還包含以下功能：
- **基本遊戲流程（擲骰子、選擇保留、填入分數）**
- **即時存檔／載入遊戲進度**
- **音效（可開關）**
- **歷史高分紀錄（支援 Firebase）**
- **動態骰子動畫與自訂 UI**

---

## 📂 專案結構

Yahtzee/
├── YahtzeeApp.swift # App 入口
├── Assets.xcassets/ # App 圖示、骰子圖片資源
│ ├── AppIcon.appiconset
│ ├── Dice/ # 骰子與 UI 素材
│ └── newLogo.imageset
├── Extension/ # 擴充功能
│ ├── ExUIColor.swift
│ └── getDiceInfo.swift
├── Model/ # 資料模型與遊戲邏輯
│ ├── CategoryModel.swift
│ ├── DateModel.swift
│ ├── Dice.swift
│ ├── GameData.swift
│ ├── GenerateInitialData.swift
│ ├── Player.swift
│ ├── PlayerData.swift
│ ├── ScoreBoard.swift
│ ├── ScoreModel.swift
│ ├── FetchModel.swift
│ └── FirebaseModel.swift
├── View/ # SwiftUI 視圖
│ ├── ContentView.swift
│ ├── BoardView.swift
│ ├── GameTableView.swift
│ ├── DiceRowView.swift
│ ├── DiceAnimateView.swift
│ ├── YahtzeeAnimateView.swift
│ ├── HeaderView.swift
│ ├── ButtonView.swift
│ ├── RowView.swift
│ ├── EndView.swift
│ ├── LeaderBoardView.swift
│ ├── LeaderBoardBarView.swift
│ ├── PanelBackgroundView.swift
│ ├── SecondPanelView.swift
│ ├── ContinueWindowView.swift
│ ├── ChangeNameView.swift
│ └── AddUpView.swift
├── ViewModel/ # ViewModel 層，處理邏輯與 UI 溝通
│ ├── ButtonViewModel.swift
│ ├── FetchViewModel.swift
│ ├── Router.swift
│ └── PenObject.swift
├── Modifier/ # SwiftUI 自訂 Modifier
│ ├── ShadowButtonModifier.swift
│ └── ShrinkButtonModifier.swift
├── Utility/ # 工具類
│ └── AudioManager.swift
├── Sound/ # 音效資源
│ └── diceRoll.mp3
├── SampleData/ # 範例資料
  └── sampleusers.json
