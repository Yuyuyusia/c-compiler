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


# 以下待修正與調整


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


## 四、字彙分析是否已完成與展示
### 前置步驟：
1. 安裝 yacc(bison) & lex(flex)
	```
	sudo apt-get install flex bison
	```


2. 檢查安裝是否成功
	```
	bison --version
	flex --version
	```
3. 將四個安裝檔案放入 final 資料夾，並藉由  `cd` 移動所在資料夾與 `ls`  查看其中所具備之檔案
	```
	cd ./Desktop/final/
	ls 
	```


4. 對 lex.l 用  `lex` 編譯，並且使用  `ls` 檢查是否有多出一個 lex.yy.c 檔案
	```
	lex lex.l
	ls
	```
	
 5. 對 yacc.y 用 `yacc` 編譯，並且使用  `ls` 檢查是否有多出一個 y.tab.c 檔案
	 ```
	 yacc yacc.y
	 ls
	 ```
 
 6. 對 yacc.y 用 `yacc` 產生標頭檔
	 ```
	 yacc -d yacc.y
	 ```
 

 
 7.  把 lex.yy.c 和 y.tab.c 合併起來，產生 cpl 執行檔
	 ```
	 cc lex.yy.c y.tab.c -o cpl
	 ```
	
 
 8. 將 sample1~7.c 之檔案移至 final 資料夾，並使用  `ls` 檢查檔案狀態
	 ```
	 ls
	 ```
	

---




### 編譯結果測試：


1. 編譯 sample1.c
	 ```
	 ./cpl < sample1.c
	 ```
	 ==正常==
 


 2. 編譯 sample2.c
	 ```
	 ./cpl < sample2.c
	 ```
	==syntax error：while 後的 ) 打成  : 號==
	
	

3. 編譯 sample3.c
	 ```
	 ./cpl < sample3.c
	 ```
	 ==正常==


 4. 編譯 sample4.c
	 ```
	 ./cpl < sample4.c
	 ```
	==syntax error：+ 號後面跟 / 號==
		 

5. 編譯 sample5.c
	 ```
	 ./cpl < sample5.c
	 ```
	 ==正常==


6.  編譯 sample6.c
	 ```
	 ./cpl < sample6.c
	 ``
	 ==syntax error：x=1的後面漏了 ; 號==
	 

7.  編譯 sample7.c
	 ```
	 ./cpl < sample7.c
	 ```
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

9. 使用 `vim` 編輯器生成**迴圈內偶數加總程式_正確版**的 c 程式並進行編譯
	```
	vim addodd1.c
	./cpl < addodd1.c
	```

	==正常==

10. 使用 `vim` 編輯器生成**迴圈內偶數加總程式_錯誤版**的 c 程式並進行編譯
	```
	vim addodd0.c
	./cpl < addodd0.c
	```
	==syntax error：迴圈內少了一個 ; 就繼續輸入 i++==


---


## 五、文法分析與組合語言生成規劃

### 組合語言生成:  (1) gcc  (2) LLVM+clang
### (1) gcc
1. 安裝更新 apt、build-essential（包含 gcc、g++、make），並檢查 gcc 是否安裝成功
	```
	sudo apt update
	sudo apt-get install build-essential
	gcc --version
	```
	

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


4. 執行 gcc_asm.sh 腳本並觀察檔案變化
	```
	ll
	./gcc_asm.sh
	ll
	```


5. 顯示預處理結果
	```
	cat g_pre
	```




6. 顯示 arm 架構組合語言
	```
	cat g_arm
	```

	
7. 顯示 x86 架構組合語言
	```
	cat g_intel

	
### (2) LLVM + clang

1. 安裝 LLVM + clang
	```
	sudo apt-get install clang llvm
	clang --version  
	llc --version
	```


2. 使用 `nano` 建立自動化腳本並更改權限
	```
	nano llvm_clang.sh
	chmod 744 llvm_clang.sh
	```

	
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

4. 執行 llvm_clang.sh 腳本並觀察檔案變化
	```
	ll
	./llvm_clang.sh
	ll
	```
	
5. 顯示前項所生成的 gcd2.ll 檔案
	```
	cat gcd2.ll
	```
	
	
6.  顯示 4. 所生成的 gcd2.s 檔案
	```
	cat gcd2.s
	```

	
7. 執行輸出檔 gcd2_llvm
	```
	./gcd2_llvm
	```
	==執行結果正確==
	
### (3) 整合軟體：makefile 
	
1. 建立自動化軟體 makefile
	```
	nano makefile
	```
	
 
2.  使用 `make` 指令一次完成本次作業（==套件、檔案需齊全==）
	```
	make all
	```

3. 觀察檔案變化
	```
	ll
	```
	##### make 之後 => 有產生應生成之檔案
	




## 六、心得
這個題目最初我們也是摸不著頭緒，不知從何下手，後來參考學長姐的範例，尤其是 LLVM 的部分，失敗多次無從解決，後來改成使用 apt 的方式安裝才成功。在後續執行上，因為有參考檔案，也有組員可以一起討論，在安裝套件跟指令的方面都有指引，降低不少難度與減少時間成本。而後半段遇到的問題中，最花時間是輸出 printf() 功能的 -lcrt1.o 不能用而要找替代方案。
在最終成功後，挑戰使用 makefile 打包所有指令，一次完成字彙分析、文法分析到組合語言生成，離一個完整的編譯器更為接近了。

(失敗例子: /usr/lib/crti.o /usr/lib/crt1.o、bashrc加入\$LIBARAY_PATH、./patchelf --set-interpreter、sudo apt-get install libc6:i386 libc6-dev-i386 等)

---

## 七、參考資料
#### 學長姐範本：
編譯器期末報告第15組（陳亦軒、洪英哲）、第32組（蔡明倫、廖祥芸）

#### 網頁資源：
https://github.com/gjlmotea
https://stackoverflow.com/questions/15466232/linking-linux-x86-64-assembly-hello-world-program-with-ld-fails/43210936
