# 需求

### Rails 習作

假設有一個電商網站要請你/妳開發後台商品管理的功能，使用的角色是`商品管理者`。請依照下面的 User Case 開發一個後台，請用你/妳習慣的工具開發完成後上傳至你/妳的 GitHub 後即可

### User Case

- 商品管理者要先登入後才能管理商品
- 商品管理者會需要上架/下架商品
- 商品會有”上架”，”下架”，”進貨中”這幾種狀態
- 前台需要顯示商品原價和售價
- 商品管理者能上傳/修改商品資料
- 商品基本屬性要有
  - SKU
  - name
  - desc (HTML)
  - 0 到多張商品圖

- 商品管理者可以新增刪除商品圖

- 商品管理者可以刪除商品

### 技術需求

- 請使用 Rails 6 以上版本
- 後台網址要放在 /admin/ path 下

### 額外需求

請設計一個訂單的優惠系統，包含訂單與優惠項目

該系統需要至少可以作到下面幾種優惠
1. 特定商品滿 X 件折 Y 元或 Z %
2. 訂單滿 X 元折 Y 元或 Z %
3. 訂單滿 X 元免運費
4. 訂單滿 X 贈送特定商品
5. 特定供應商場品滿 X 件折 Y 元或 Z %
6. 折扣可限定只套用 N 次或總共優惠 Y 元
7. 折扣可限制特定時間內有效或是每月重新計算使用數量限制

# 環境

- Ruby: 2.6.3

- Rails: 6.0.2

- Database: mysql

## 後台實作

1. 安裝node.js

2. 安裝yarn

3. `rails webpacker:install`

4. 什麼是`SKU`?

   SKU的中文稱為「單品」，一般應用在生產者與物流業者管理其商品之最小分類單位。早期的商店販賣一般以「品種」來區分，但「品種」似乎已漸漸無法跟上現在社會的需求。

   基本上「單品」與「品種」有些差異，比如說iPhone的「品種」可以區分為iPhone6、iPhone6s、iPhone 6 Plus、iPhone 6s Plus、iPhone SE…等，但是客戶下單的時候除了選擇「品種」外，往往還會再指定iPhone的顏色、記憶體大小…等，所以「品種」已經無法滿足現今客戶多樣化的下單需求。

   於是「單品」的觀念興起，再拜電腦管理及查詢方便之賜，於是「SKU(單品)」被大量應用在現今電商所販賣的所有商品管控當中，而SKU也漸漸被引申為「產品統一編號」，也就是每種產品都會對應到一個唯一的SKU號，比如我們在網路PChome購買商品時，其實都會帶出一個該商品唯一的編號。

   結論：`SKU`是訂單號的意思，型態為字串

5. `rails s` 確定可以動

6. 安裝`devise`, `mysql`, `pry`

   ````ruby
   # bootstrap 4
   gem 'bootstrap', '~> 4.4.1'

   # devise
   gem 'devise'
   gem 'devise-i18n'
   gem 'devise-bootstrap-views'

   group :development, :test do
     gem 'mysql2'
     gem 'pry'
     gem 'pry-nav'
     gem 'pry-rails'
   end
   ````

7. 商品屬性

   - name
   - SKU（訂單號碼）
   - status：商品會有”上架”，”下架”，”進貨中”這幾種狀態
     - 上架 (on)：1
     - 進貨中(stock)：0
     - 下架 (off)：-1
   - 0 到多張商品圖

8. 確定`model`後，完成接續的Routes, Controller, View

9. 側邊欄

   - 後台管理系統產品須上架，以及操作優惠管理系統，需要透過側邊欄選擇頁面
   - 側邊欄參考網站在[這裡](https://bootsnipp.com/snippets/N6pQ6)

10. 如果想要在個人賣場加入Profile，請參考[這篇](https://medium.com/luanotes/build-instagram-by-ruby-on-rails-part-1-fef7837ee399)網站。首先要先在User表中開更多欄位。如果想要看原始碼的話，[這邊](https://github.com/thanhluanuit/instuigram)有Github連結

````shell
rails g migration AddMoreFieldsToUsers name:string website:string bio:text phone:integer gender:string
````

11. Toogle Button Example: [Link](https://www.w3schools.com/howto/howto_css_switch.asp)
12. 目前後台共有個人頁面、編輯個人頁面、商品管理系統、優惠系統

## 前台實作

9. 控制器新增`index`, `show`動作

2. 進去頁面前不用先登入

3. 只顯示上架中的商品



## Heroku

有時候自己有重置資料庫的需求，所以需要Heroku的資料庫名及重置資料庫的指令。

如何[查詢]( https://devcenter.heroku.com/articles/heroku-postgresql)資料庫名字： `heroku pg:info --app=hanting-shop`

如何[重置](https://stackoverflow.com/questions/4820549/how-to-empty-a-heroku-database)資料庫：`heroku pg:reset DATABASE_URL`

跑完重置後，請跑：`heroku run rake db:migrate  `

以`hanting-shop`為例，需要跑以下指令

````shell
heroku pg:reset postgresql-concentric-46793 --app=hanting-shop
heroku run rake db:migrate --app=hanting-shop 
````

## Controller

Rails 5 轉址返回使用`redirect_back`[說明](https://blog.bigbinary.com/2016/02/29/rails-5-improves-redirect_to_back-with-redirect-back.html)

## Model

如何使用 `build_profile` 和 `create_profile`：[這裡](https://stackoverflow.com/questions/7024301/what-is-the-difference-between-the-build-and-create-method-in-activerecord-relat/7024375)

## 資料庫

指令懶人包：`rails db:drop db:create db:migrate db:seed`



## 尚未完成

- `Admin::ProductsController` 的`status` 動作預期為改變狀態用，不過後來沒寫
- 沒有寫測試

### Javascript

- 淺談javascript, jQuery的Checkbox：[連結](https://www.w3schools.com/JSREF/prop_checkbox_checked.asp)、[連結](https://codertw.com/%E5%89%8D%E7%AB%AF%E9%96%8B%E7%99%BC/262020/)
- 

### 成品

註冊頁面：`username`, `email`, `password`

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/signup.jpg)

登入畫面：`login`, `password`

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/login.jpg)

商品列表

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/recent-index.jpg)

預期`商品列表`頁面，後來來不及寫`button group`的JS

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/expected-index.jpg)

檢視商品

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/show.jpg)

新增列表

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/new.jpg)

編輯列表

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/edit.jpg)

刪除列表

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/delete.gif)

後台新增側邊欄

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/sidebar.png)

前台列表

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/client_index.jpg)

前台檢視商品（自己的商品）

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/modal.jpg)

前台檢視商品（別人的商品）

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/modal2.png)

使用者加入錢包欄位（不過做完才想到拍賣網站沒有遊戲儲值的行為）

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/wallet.jpg)

新增訂單資料表（若購買別人商品即形成訂單）

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/order.jpg)

後台新增商品使用Cookie

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/cookie.jpg)

後台編輯個人頁面

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/profile.png)

後台優惠系統

![image](https://github.com/ChenHanTing/product-cms/blob/master/doc-pics/ODM.png)



# 參考資料

1. 新增 Username（使用者名稱）[欄位](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address)
2. CSS：上傳圖片太大顯示[縮小](https://digishot.keenchief.com/tw/4163656835/4163656835)
3. Bootstrap：[Navbar](https://www.codeply.com/go/qhaBrcWp3v)、 [Button font color](https://stackoverflow.com/questions/12471132/how-to-set-text-color-in-submit-button)、modal 內容太多如何[處理](https://getbootstrap.com/docs/4.4/utilities/overflow/)
4. rails 的 [bootstrap simple_form](http://simple-form-bootstrap.plataformatec.com.br/examples/horizontal) 語法
5. 如何製造[流水號](https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby)：
6. Rails 6 [使用 jQuery](https://www.botreetechnologies.com/blog/introducing-jquery-in-rails-6-using-webpacker)
7. 看不懂`.modal()`[解決方式](https://stackoverflow.com/questions/58371711/bootstrap-hide-modal-not-working-in-rails-6-using-ajax)
8. [Enum] `ArgumentError ('1' is not a valid status)` 的2種[解決方法](https://stackoverflow.com/questions/47567790/getting-1-is-not-a-valid-status-after-giving-enum-datatype-in-model)

