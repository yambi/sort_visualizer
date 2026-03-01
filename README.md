# Sorting Algorithm Visualizer

ソートアルゴリズムの動作を色付きの線で可視化するWebアプリケーションです。各要素の移動を色相で表現し、ソートの過程を一枚の画像として描画します。

## 対応アルゴリズム

- Bubble Sort / Odd Even Sort / Shaker Sort
- Comb Sort / Shell Sort
- Insertion Sort / Binary Sort / Selection Sort
- Quick Sort / Modified Quick Sort / Java Sort
- Merge Sort / Strand Sort / Heap Sort
- Radix Sort / Bucket Sort
- Stooge Sort / Bogo Sort / Bozo Sort / Goro Sort

## 操作方法

| 項目 | 説明 |
|------|------|
| アルゴリズム選択 | ドロップダウンからソートアルゴリズムを選択 |
| auto shuffle | ソート実行前に自動でシャッフル |
| random / reverse | 入力配列をランダムまたは逆順に初期化 |
| sort | 選択したアルゴリズムでソートを実行・描画 |
| save | 描画結果をPNG画像として保存 |
| elements | 要素数 (2-256) |
| thickness | 線の太さ |
| alpha | 線の透明度 |

## 技術構成

- HTML5 Canvas
- Vanilla JavaScript (フレームワーク不使用)
- CSS3
