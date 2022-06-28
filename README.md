# c_compiler
ubuntu 20.04.4

# 編譯器期末專題
#### 組別：第 8 組
#### 組員：Yusia & two else
#### 日期：2022.06.06

---

## 執行方法
#### 於 ubuntu 環境中建立以下的 init.sh 檔案後（使用 vim 或 nano）
	```
	init.sh
	```
###### init.sh
	```shell
	mkdir final
	cd final
	echo "password" | sudo -S apt-get install -y git build-essential flex bison llvm clang
	git clone https://github.com/Yuyuyusia/c-compiler
	cd c-compiler
	make all
	```

#### 執行 init.sh 即可完成本次報告所有範圍
 	```
	source init.sh
	```


# 以下為簡易說明


---

## 大綱
#### 一、簡介開發何種程式語言編譯器
#### 二、使用何種語言開發
#### 三、軟硬體版本
#### 四、心得
#### 五、參考資料

---

## 一、簡介開發何種程式語言編譯器

#### 實作一個 C 語言的編譯器


## 二、使用何種語言開發


### 字彙分析、語法分析
#### 使用 yacc 與 lex

| 名稱   | 分析器             | 用途  |
| ---------- | ---------------- | ------ |
| yacc | 語法分析器 | 用來處理 lex 輸出的 token |
| lex | 字彙分析器 | 切出所有的 token | 


### 組合語言
#### 方法1：使用 **gcc**
#### 方法2：使用 **LLVM+Clang**

---

## 三、軟硬體版本
### 環境：Windows 10 家用版
### 軟體：VMware Workstation 16 Pro
### 虛擬機：Ubuntu 20.04.4 版本

---

## 四、心得
這個題目最初我們也是摸不著頭緒，不知從何下手，後來參考學長姐的範例，尤其是 LLVM 的部分，失敗多次無從解決，後來改成使用 apt 的方式安裝才成功。在後續執行上，因為有參考檔案，也有組員可以一起討論，在安裝套件跟指令的方面都有指引，降低不少難度與減少時間成本。而後半段遇到的問題中，最花時間是輸出 printf() 功能的 -lcrt1.o 不能用而要找替代方案。
在最終成功後，挑戰使用 makefile 打包所有指令，一次完成字彙分析、文法分析到組合語言生成，離一個完整的編譯器更為接近了。

(失敗例子: /usr/lib/crti.o /usr/lib/crt1.o、bashrc加入\$LIBARAY_PATH、./patchelf --set-interpreter、sudo apt-get install libc6:i386 libc6-dev-i386 等)

---

## 五、參考資料
#### 學長姐範本：
編譯器期末報告第15組（陳亦軒、洪英哲）、第32組（蔡明倫、廖祥芸）

#### 網頁資源：
https://github.com/gjlmotea
https://stackoverflow.com/questions/15466232/linking-linux-x86-64-assembly-hello-world-program-with-ld-fails/43210936
