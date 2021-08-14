const pay = () => {
  // Pay.jpに送る公開鍵をセット
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // 送信ボタンの要素を取得
  const submit = document.getElementById("button");
  // 送信ボタンをクリックしたらイベント発火
  submit.addEventListener("click", (e) => {
    // 通常のリクエストの送信をキャンセル ※このファイルからサーバーへリクエストを送る為
    e.preventDefault();
    // form要素を取得する
    const formResult = document.getElementById("charge-form");
    // form要素の中身（値）を取得する
    const formData = new FormData(formResult);
    // form要素の中身から、クレカ情報を取得する
    const card = {
       number: formData.get("buyer_receiver_address[number]"),
       cvc: formData.get("buyer_receiver_address[cvc]"),
       exp_month: formData.get("buyer_receiver_address[exp_month]"),
       exp_year: `20${formData.get("buyer_receiver_address[exp_year]")}`,
    }

    // 第一引数はカード情報・第二引数はtokenを受け取った後に実行する処理。
    Payjp.createToken(card, (status, response) => {
      // HTTPステータスが200なら(処理が完了していたら)、続行する
      if (status == 200) {
        // tokenの値を取得
        const token = response.id;
        
        ///tokenの値をformに含める
        // form要素を取得
        const formAddToken = document.getElementById("charge-form");
        // tokenの値をHTMLのinput要素に埋め込む。 ※name='token'でparams[:token]で値を取得できる。※type="hidden"でブラウザ上で非表示にする
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // formに生成したinput要素を追加する。
        formAddToken.insertAdjacentHTML("beforeend", tokenObj);
      }

      // formからカード情報を削除する
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
    
      // formデータをサーバーサイドへ送信する
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);