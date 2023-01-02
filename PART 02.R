## 데이터 입력 및 불러오기

# 자료 입력(국어, 수학 성적)
kor=c(90,80,70)
math=c(70,90,60)
score=data.frame(kor,math) ; score
  # data.frame(kor=c(90,80,70),math=c(70,90,60))도 가능

View(score)     #생성된 데이터 보기

mean(score$kor) ; mean(score$math)  # 과목 평균 확인

# 엑셀 파일 불러오기
install.packages("readxl") ; library(readxl)
excel_exam=read_excel("excel_exam.xlsx")              # 저장된 위치에서 멕셀파일 불러오기
read_excel("excel_exam.xlsx",sheet=2)                 # 2번째 시트 불러오기
read_excel("excel_exam.xlsx",sheet=3, col_names = F)  # 변수명 없는 경우

# TSV(탭으로 구분)파일 불러오기
read.table("tsv_exam.tsv")
read.table("tsv_exam.tsv", header = T)                # 1행을 변수명으로 사용
read.table("tsv_exam.tsv", header = T, skip=2)        # 2개 행 skip 3번째 행부터
read.table("tsv_exam.tsv", header = T, nrow=5)        # 5개 행만 불러오기

# CSV(쉼표로 구분)파일 불러오기
read.csv("csv_exam.csv")

# 파일 저장
# write.table(data명, file = "저장할 위치와 파일명",quote=FALSE) / quote는 따옴표 제거
# write.csv(data명, file = "저장할 위치와 파일명")

#----------------------------------------------------------------------------------------#

## 데이터 파악 및 가공

library(readxl)
score = read_excel("excel_exam.xlsx")

View(score)     # 데이터 파악(엑셀 형태)
str(score)      # 변수 속성
dim(score)      # 행, 열(10행 3열) 파악
ls(score)       # 변수명 / colnames(score) 동일
head(score)     # 위에서부터 6개 행 / head(score,8) : 8개 행 볼 수 있음
tail(score)     # 밑에서부터 6개 행 / tail(score,8)
summary(score)  # 변수 값들 요약


install.packages("dplyr") ; library(dplyr)
jeju = read.csv("jeju.csv",fileEncoding = "euc-kr")   
          # 파일 불러올때 (invalid multibyte string at)오류 생길시 fileEncoding 사용

rename(jeju, 대륙 = 구분, 나라 = 상세)    # 새 변수명이 기존 변수명보다 먼저

jeju$quarter1 = jeju$X2018년1월+jeju$X2018년2월+jeju$X2018년3월     # 1분기 변수 생성

jeju$nation5000 = 
  ifelse(jeju$X2018년1월>=5000,"Y","N")   # 1월 5000명이상 방문 시 "Y" 아니면 "N"
View(jeju)

jeju$nation5000 = 
  ifelse(jeju$X2018년1월>=7000,"A",
         ifelse(jeju$X2018년1월>=5000,"B",
                ifelse(jeju$X2018년1월>=3000,"C","D")))
View(jeju)


install.packages("descr") ; library(descr)

freq(jeju$구분)   # 빈도, 비율, 막대그래프 생성


## 헷갈릴수 있는 연산

3/5             # 흔히 아는 나누기 값
3%/%5           # 몫
3%%5            # 나머지

1==1            # 동일한지 판단 위해서는 "==" 사용 (결과는 TRUE or FALSE)
1!=1            # 동일하지 않다 "!=" 사용
1*(1==1)        # TRUE * 1 = 1 
1*(1!=1)        # FALSE * 1 = 0

x=3
(x>1) & (x>4)   # and 연산 (두 조건 모두 만족시 TRUE)
(x>1) | (x>4)   # or 연산 (두 조건 중 하나라도 만족시 TRUE) - Shift+(Enter 위에 키)


## 그래프 그리기

install.packages("ggplot2") ; library(ggplot2)


# R 내장 데이터 swiss사용
ggplot(swiss,aes(x=Catholic,y=Education)) +     # ggplot : 배경만들기
  geom_point()                                  # 산점도 그래프


exam=read.csv("csv_exam.csv")
stem(exam$math)                           # 줄기 잎 그래프
hist(exam$math, main = "math grade")      # 히스토그램
barplot(table(exam$class))                # 막대그래프(table이용해서 빈도수 구하기)
barplot(table(exam$class), main = "class number",
        names=c("1반","2반","3반"),
        col=c("blue","blue","skyblue"))   # 다양한 옵션 존재


## 결측치 및 이상치 제거

ex = data.frame(id = c(1:5),
                age = c(20,21,NA,23,80),
                area = c("서울",NA,"부산","제주",NA))
ex            # age, area에 결측값 포함 (수치 : NA / 문자 : <NA>)

is.na(ex)     # 결측일 경우 TRUE 아니면 FALSE

mean(ex$age)                              # 결측 있을 경우 결과값 NA
mean(ex$age, na.rm = TRUE)                # 결측 제거 후 평균

ex$age = ifelse(ex$age >= 30, NA, ex$age) # 30세 이상 이상치로 간주(결측치로 변환)
mean(ex$age, na.rm = TRUE)                # 평균 매우 낮아짐

na.omit(ex)   # 결측 하나라도 있는 행 모두 제거


ex2 = data.frame(id=c(1:6),
                 age=c(20,21,22,23,80,1),
                 sex=c("F","M","F","M","M","A"))

boxplot(ex2$age)    # 점 찍혀 있는 부분 이상치로 간주(Q1-1.5*IQR,Q3+1.5*IQR 벗어나는 점)
