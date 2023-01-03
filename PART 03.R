## dplyr 패키지
install.packages("dplyr") ; library(dplyr)

exam=read.csv("csv_exam.csv")

select(exam,class)    # 원하는 열 선택
select(exam,-class)   # 특정 열 제외하고 선택

exam %>% filter(math>=50)             # math 50점 이상 선택
exam %>% filter(class==3)             # class 3 선택
exam %>% filter(math>=50 & class==3)  # 두 조건 모두 만족
                                      # 문자형일 경우 "" 붙이기(변수명 = "~")

exam %>% arrange(english)                 # 영어점수 기준 오름차순
exam %>% arrange(desc(english))           # 영어점수 기준 내림차순
exam %>% arrange(math, desc(english))     # 수학 점수 기준 오름차순 후 
                                          # 동점일 경우 영어점수 기준 내림차순

summarise(exam, mean(science),median(science),min(science),max(science))  # 요약
summarise(exam, science_mean=mean(science),
          science_median=median(science),
          science_min=min(science),
          science_max=max(science))  # 변수명 설정 가능

exam %>% group_by(class) %>%
  summarise(mean_science = mean(science))   # class별 과학점수 평균


mutate(exam, date="2023년 1월")             # 새로운 열 추가
mutate(exam, total=math+english+science)    # 총점 열 추가

distinct(exam,math)           # 수학점수 중복값 제거
distinct(exam,english)        # 영어점수 중복값 제거
distinct(exam,math,english)   # 수학,영어 점수 중복값 제거

#-------------------------------------------------------------------------------------------#

## 데이터 병합

group_a = data.frame(id=c(1,2), area=c("제주","서울"))
group_b = data.frame(id=c(3,4), area=c("부산","서울"))

bind_rows(group_a,group_b)    # a,b 그룹 세로로 결합

# 가로로 결합
exam1 = data.frame(id=c(1,2,3),area=c("제주","서울","부산"))
exam2 = data.frame(id=c(1,2), gender=c("M","F"))

left_join(exam1,exam2,by="id")      # exam1 id 기준으로 병합
right_join(exam1,exam2,by="id")     # exam2 id 기준으로 병합

inner_join(exam1,exam2,by="id")     # id 기준으로 병합 (두 data에 동시에 존재)
full_join(exam1,exam2,by="id")      # id 기준 (둘 중 하나라도 존재 시)

#-------------------------------------------------------------------------------------------#

## reshape2 패키지 (행 -> 열, 열-> 행으로 변환)

install.packages("reshape2") ; library(reshape2)

# 1. wide -> long
car = mtcars                                # 내장데이터 이용
car1 = mutate(car, id=1:32) ; head(car1)    # car data에 id 열 추가

car_melt = melt(car1, id.vars = "id")       # id 기준 long format
View(car_melt)
head(car_melt) ; tail(car_melt)             # 한 행에 변수와 값 하나씩

# 2. long -> wide
car_dcast = dcast(car_melt, id~variable)    # 기준열 ~ 반환열
View(car_dcast)                             # 원 상태로 복구

car_melt2 = mutate(car_melt, year="2023")         # car_melt에 year 열 추가
car_acast = acast(car_melt2, id~year~variable)    # 기준열 ~ 반환 열 ~ 분리 기준 열
car_acast                                         # 각 연도에 해당하는 변수 값 확인 가능 

#-------------------------------------------------------------------------------------------#

## ggplot2 패키지

install.packages("ggplot2") ; library(ggplot2)

ggplot(mtcars, aes(x=mpg,y=cyl)) +        # x축 mpg, y축 cyl인 배경 만들기
  geom_point(size=2, color="blue") +      # 산점도 그림 (크기2인 파란점)
  theme_bw()                              # 배경 설정(theme 이용)

ggplot(mtcars, aes(x=cyl)) +              # 막대 그래프의 경우 변수 1개로 가능
  geom_bar(width = 0.3)                   # 막대 두께 조절           

ggplot(mtcars, aes(x=mpg)) +
  geom_histogram()                        # 히스토그램 또한 변수 1개로 가능

# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. 
ggplot(mtcars, aes(x=mpg)) +
  geom_histogram(bins = 2)                # bins는 구간의 개수
                                          # R에서 자동으로 30개의 구간을 설정해줌
ggplot(mtcars, aes(x=mpg)) +
  geom_histogram(binwidth = 1)            # 막대 너비를 설정해주면 알아서 구간 나눠줌


ggplot(airquality, aes(x=Day, y=Temp, group=Day)) +
  geom_boxplot()                                # 일자별 온도 상자 그래프

ggplot(airquality,aes(x=Day, y=Temp)) +
  geom_line() +                                 # 일자별 온도 꺽은선 그래프
  labs(x="일자", y="온도", 
       title="1973.05_뉴욕의 일자별 온도")      # 그래프에 제목 및 축 이름 설정

#-------------------------------------------------------------------------------------------#

## 추론 통계

# 상관분석
# 귀무가설 : 두 변수 간에 상관관계가 없다 vs 귀무가설 : 상관관계가 존재한다

cor.test(mtcars$mpg, mtcars$cyl)    

# p-value가 0.05보다 작기때문에 유의수준 5%에서 통계적으로 유의하다
# 즉, 귀무가설 채택할 근거가 부족하다
# 따라서 두 변수 간에는 음의 상관관계(cor=-0.85)가 있을 것으로 보인다


# t 검정 (평균 비교)
# 귀무가설 : 두 집단 간 평균 차이가 없다 vs 대립가설 : 두 집단 간에 평균차이가 존재한다

library(readxl)

exam = read_excel("excel_exam2.xlsx")

t.test(data=exam, korean~sex, var.equal=T)    # "data = " 생략 불가능
# 등분산 가정하에서 성별에 따라 국어성적에 차이가 있는가?
# p-value가 0.05보다 크기 때문에 귀무가설 기각할 근거 없다
# 따라서 성별에 따라 국어성적에 차이가 있다고 할 수 없다.

t.test(data=exam ,math~sex, var.equal = T)
# 위 결과와 동일