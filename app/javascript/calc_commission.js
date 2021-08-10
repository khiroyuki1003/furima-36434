function calculation(){
  // 金額入力欄の要素を取得
  const priceInput = document.getElementById("item-price")
  // 金額入力欄に値が入力されたら関数を実行する
  priceInput.addEventListener('input', function(){
    // 金額入力欄の要素の値を取得する
    const inputValue = priceInput.value
    // 販売手数料を計算する。（Math.floorで切り捨て）※Mathオブジェクト
    const calcCommission = Math.floor(inputValue * 0.1)
    // 販売手数料の表示欄の要素を取得
    const commission = document.getElementById("add-tax-price")
    // 販売手数料を表示させる
    commission.innerHTML = calcCommission
    // 販売利益を計算する。
    const calcProfit = Math.floor(inputValue - calcCommission)
    // 販売利益の表示欄の要素を取得
    const profit = document.getElementById("profit")
    // 販売利益を表示させる
    profit.innerHTML = calcProfit
  })
}

// ページが更新されたらイベント発火し、calculation関数を実行する
window.addEventListener('load', calculation)
