# c_compiler
ubuntu 20.04.4

# 編譯器期末專題
#### 組別：第 8 組
#### 組員：軟工三 S05730040 陳澤茗、S06730037 范家豪、S07730035  李佳勳
#### 日期：2022.06.06

---

## 大綱
#### 一、簡介開發何種程式語言編譯器
#### 二、使用何種語言開發
#### 三、軟硬體版本
#### 四、字彙分析是否已完成與展示
#### 五、文法分析與組合語言生成規劃
#### 六、心得
#### 七、參考資料

---

## 一、簡介開發何種程式語言編譯器

#### 實作一個 C 語言的編譯器
![[Pasted image 20220607114706.png]]

---

<div style="page-break-after: always;"></div>


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

<div style="page-break-after: always;"></div>

## 三、軟硬體版本
### 環境：Windows 10 家用版
![[Pasted image 20220606044055.png]]
### 軟體：VMware Workstation 16 Pro
![[Pasted image 20220606044120.png]]
### 虛擬機：Ubuntu 20.04.4 版本
![[Pasted image 20220606044030.png]]

**補充 3D vacs 環境


---

<div style="page-break-after: always;"></div>

## 四、字彙分析是否已完成與展示
### 前置步驟：
1. 安裝 yacc(bison) & lex(flex)
	```
	sudo apt-get install flex bison
	```
	![[Pasted image 20220606040128.png]]

2. 檢查安裝是否成功
	```
	bison --version
	flex --version
	```
	![[Pasted image 20220606040721.png]]

3. 將四個安裝檔案放入 final 資料夾，並藉由  `cd` 移動所在資料夾與 `ls`  查看其中所具備之檔案
	```
	cd ./Desktop/final/
	ls 
	```
	![[Pasted image 20220606040941.png]]


<div style="page-break-after: always;"></div>	

4. 對 lex.l 用  `lex` 編譯，並且使用  `ls` 檢查是否有多出一個 lex.yy.c 檔案
	```
	lex lex.l
	ls
	```
	 ![[Pasted image 20220606041016.png]]
 
 5. 對 yacc.y 用 `yacc` 編譯，並且使用  `ls` 檢查是否有多出一個 y.tab.c 檔案
	 ```
	 yacc yacc.y
	 ls
	 ```
	![[Pasted image 20220606041050.png]]
 
 6. 對 yacc.y 用 `yacc` 產生標頭檔
	 ```
	 yacc -d yacc.y
	 ```
	![[Pasted image 20220606041127.png]]
 
<div style="page-break-after: always;"></div>

 
 7.  把 lex.yy.c 和 y.tab.c 合併起來，產生 cpl 執行檔
	 ```
	 cc lex.yy.c y.tab.c -o cpl
	 ```
	![[Pasted image 20220606041222.png]]
 
 8. 將 sample1~7.c 之檔案移至 final 資料夾，並使用  `ls` 檢查檔案狀態
	 ```
	 ls
	 ```
	![[Pasted image 20220606041346.png]]

---

<div style="page-break-after: always;"></div>


### 編譯結果測試：


1. 編譯 sample1.c
	 ```
	 ./cpl < sample1.c
	 ```
	![[Pasted image 20220606041543.png]]
	![[Pasted image 20220606041519.png]]
	 ==正常==
 

<div style="page-break-after: always;"></div>


 2. 編譯 sample2.c
	 ```
	 ./cpl < sample2.c
	 ```
	![[Pasted image 20220606041626.png]]
	==syntax error：while 後的 ) 打成  : 號==
	
	

3. 編譯 sample3.c
	 ```
	 ./cpl < sample3.c
	 ```
	![[Pasted image 20220606041646.png]]
	 ==正常==


 4. 編譯 sample4.c
	 ```
	 ./cpl < sample4.c
	 ```
	![[Pasted image 20220606041710.png]]
	==syntax error：+ 號後面跟 / 號==
		 

<div style="page-break-after: always;"></div>

5. 編譯 sample5.c
	 ```
	 ./cpl < sample5.c
	 ```
	![[Pasted image 20220606041723.png]]
	 ==正常==


6.  編譯 sample6.c
	 ```
	 ./cpl < sample6.c
	 ```
	![[Pasted image 20220606041742.png]]
	 ==syntax error：x=1的後面漏了 ; 號==
	 

7.  編譯 sample7.c
	 ```
	 ./cpl < sample7.c
	 ```
	![[Pasted image 20220606041808.png]]
	 ==syntax error：漏了 } 號==
	


8. 撰寫預進行測試的 c 程式
	```C
	int main()
	{
		int count = 0;
		int i = 1;
		for (i=1; i<=100; i++) {
			if (i % 2 != 0)continue;
			else{
				count = count + i;
			}
		};
		printf( "add all odd numbers in 1 ~ 100 : ") ;
		printf( "%d", count );
		return 0;
	}
	```


<div style="page-break-after: always;"></div>


9. 使用 `vim` 編輯器生成**迴圈內偶數加總程式_正確版**的 c 程式並進行編譯
	```
	vim addodd1.c
	./cpl < addodd1.c
	```
	![[Pasted image 20220606043048.png]]
	![[Pasted image 20220606043105.png]]
	==正常==

10. 使用 `vim` 編輯器生成**迴圈內偶數加總程式_錯誤版**的 c 程式並進行編譯
	```
	vim addodd0.c
	./cpl < addodd0.c
	```
	![[Pasted image 20220606091841.png]]
	![[Pasted image 20220606043831.png]]
	==syntax error：迴圈內少了一個 ; 就繼續輸入 i++==


---

<div style="page-break-after: always;"></div>

## 五、文法分析與組合語言生成規劃

### 組合語言生成:  (1) gcc  (2) LLVM+clang
### (1) gcc
1. 安裝更新 apt、build-essential（包含 gcc、g++、make），並檢查 gcc 是否安裝成功
	```
	sudo apt update
	sudo apt-get install build-essential
	gcc --version
	```
	![[Pasted image 20220606024314.png]]

2. 使用 `nano` 建立自動化腳本並更改權限
	```
	nano gcc_asm.sh
	chmod 744 gcc_asm.sh
	```
	```sh
	#gcd.c
	gcc -E gcd.c -o g_pre
	gcc -S gcd.c -o g_arm
	gcc -S -masm=intel -o g_intel
	```
	![[Pasted image 20220606064723.png]]
	![[Pasted image 20220606065500.png]]
	![[Pasted image 20220606065501.png]]

<div style="page-break-after: always;"></div>

3. 使用 `vim` 編輯器新增 gcd.c 檔案
	```
	vim gcd.c
	```
	```c
	#include <stdio.h>
	void swap(int *n1, int *n2){
			int temp=*n1;
			*n1=*n2;
			*n2=temp;
	}       

	int main(){
			int a=84, b=56, c;
			printf("a=%d b=%d ",a,b);
			if (a==0 || b==0) return 0;
			if (b>a) swap(&a,&b);
			while (a%b){
					c=a;
					a=b;
					b=c%b;
			}       
			printf("gcd=%d\n",b);
			return 0;
	}                   
	```
	![[Pasted image 20220606065030.png]]

<div style="page-break-after: always;"></div>

4. 執行 gcc_asm.sh 腳本並觀察檔案變化
	```
	ll
	./gcc_asm.sh
	ll
	```
	![[Pasted image 20220606065309.png]]
	![[Pasted image 20220606071016.png]]

5. 顯示預處理結果
	```
	cat g_pre
	```
	![[Pasted image 20220606065828.png]]
	（略）
	![[Pasted image 20220606065830.png]]
	（略）
	![[Pasted image 20220606065831.png]]

<div style="page-break-after: always;"></div>

6. 顯示 arm 架構組合語言
	```
	cat g_arm
	```
	![[Pasted image 20220606070123.png]]
	（略）
	![[Pasted image 20220606070127.png]]
	
7. 顯示 x86 架構組合語言
	```
	cat g_intel
	```
	![[Pasted image 20220606070307.png]]
	（略）
	![[Pasted image 20220606070311.png]]
	
<div style="page-break-after: always;"></div>
	
	### (2) LLVM + clang
1. 安裝 LLVM + clang
	```
	sudo apt-get install clang llvm
	clang --version  
	llc --version
	```
	![[Pasted image 20220606071937.png]]
	![[Pasted image 20220606072151.png]]

2. 使用 `nano` 建立自動化腳本並更改權限
	```
	nano llvm_clang.sh
	chmod 744 llvm_clang.sh
	```
	![[Pasted image 20220606072411.png]]
	![[Pasted image 20220606073032.png]]
	
3.  使用 `vim` 編輯器新增 gcd2.c 檔案
	```
	vim gcd2.c
	```
	```c
	#include <stdio.h>

	int main(){
		int a=84,b=56,c;
		while (a%b){
			c = a;
			a = b;
			b = c % b;
		}
		printf("%d\n",b);
		return 0;
	}
	```
	![[Pasted image 20220606074430.png]]

4. 執行 llvm_clang.sh 腳本並觀察檔案變化
	```
	ll
	./llvm_clang.sh
	ll
	```
	![[Pasted image 20220606075104.png]]
	![[Pasted image 20220606075106.png]]

5. 顯示前項所生成的 gcd2.ll 檔案
	```
	cat gcd2.ll
	```
	![[Pasted image 20220606075418.png]]
	（略）
	![[Pasted image 20220606075431.png]]
	
6.  顯示 4. 所生成的 gcd2.s 檔案
	```
	cat gcd2.s
	```
	![[Pasted image 20220606075823.png]]
	（略）
	![[Pasted image 20220606075934.png]]
	
7. 執行輸出檔 gcd2_llvm
	```
	./gcd2_llvm
	```
	![[Pasted image 20220606092109.png]]
	且其執行結果正確
	![[Pasted image 20220606080538.png]]
	
	### (3) 整合軟體：makefile 
1. 建立自動化軟體 makefile
	```
	nano makefile
	```
	![[Pasted image 20220606081954.png]]
 
2.  使用 `make` 指令一次完成本次作業（==套件、檔案需齊全==）
	```
	make all
	```
	![[Pasted image 20220606082302.png]]
	（略）
	![[Pasted image 20220606082411.png]]
	（略）
	![[Pasted image 20220606082501.png]]
	（略）
	![[Pasted image 20220606082551.png]]
	
3. 觀察檔案變化
	```
	ll
	```
	##### make 之前
	![[Pasted image 20220606082804.png]]
	##### make 之後 => 有產生應生成之檔案
	![[Pasted image 20220606082802.png]]


---

<div style="page-break-after: always;"></div>

## 六、心得
這個題目最初我們也是摸不著頭緒，不知從何下手，後來參考學長姐的範例，尤其是 LLVM 的部分，失敗多次無從解決，後來改成使用 apt 的方式安裝才成功。在後續執行上，因為有參考檔案，也有組員可以一起討論，在安裝套件跟指令的方面都有指引，降低不少難度與減少時間成本。而後半段遇到的問題中，最花時間是輸出 printf() 功能的 -lcrt1.o 不能用而要找替代方案。
在最終成功後，挑戰使用 makefile 打包所有指令，一次完成字彙分析、文法分析到組合語言生成，離一個完整的編譯器更為接近了。

(失敗例子: /usr/lib/crti.o /usr/lib/crt1.o、bashrc加入\$LIBARAY_PATH、./patchelf --set-interpreter、sudo apt-get install libc6:i386 libc6-dev-i386 等)

---

## 七、參考資料
#### 學長姐範本：
編譯器期末報告第15組（陳亦軒、洪英哲）、第32組（蔡明倫、廖祥芸）

#### 網頁資源：
https://stackoverflow.com/questions/15466232/linking-linux-x86-64-assembly-hello-world-program-with-ld-fails/43210936
