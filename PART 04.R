## 제주도는 어느 나라에서 가장 많이 올까?

# install.packages("dplyr") ; install.packages("ggplot2")
library(dplyr) ; library(ggplot2)

jeju = read.csv("jeju2.csv",fileEncoding = "euc-kr") ; jeju

jeju2 = subset(jeju, select = c(-구분, -데이터기준일자))    # 필요없는 변수 제거
jeju2

# 변수명 변경
names(jeju2) = c("country","Y_1","Y_2","Y_3","Y_4","Y_5","Y_6",
                 "Y_7","Y_8","Y_9","Y_10","Y_11","Y_12")
jeju2 ; str(jeju2)    # 데이터 구조 파악


# 파생변수 생성 (국가별 방문 총합)
jeju2 = jeju2 %>% mutate(sum = Y_1 + Y_2 + Y_3 + Y_4 + Y_5 + Y_6 + Y_7 +
                           Y_8 + Y_9 + Y_10 + Y_11 + Y_12)
jeju2


# 시각화
ggplot(jeju2, aes(x=reorder(country,-sum), y=sum)) +      # sum기준 내림차순
  geom_col()


ggplot(jeju2, aes(x=reorder(country,-sum), y=sum)) +      
  geom_col() + coord_polar()                              # 선버스트 차트


options(scipen=100)                                       # 숫자표기법 변경(y축)
ggplot(jeju2, aes(x=reorder(country,-sum), y=sum)) +      
  geom_col() + coord_polar()                              # 선버스트 차트

#----------------------------------------------------------------------------------------#

## 어떤 살충제가 모기를 가장 많이 잡을까?

# 얼마나 많은 해충을 죽였는가에 관한 데이터
spray = read.csv("spray_test.csv")

str(spray)

# 시각화
boxplot(spray$A,spray$B,spray$C,spray$D,spray$E,
        main = "Spray_Test", names = c("A","B","C","D","E"),
        col = c("green","yellow","blue","skyblue","gray"))

# D 살충제의 경우 상자가 상대적으로 아래에 위치해 있다 (성능 가장 떨어짐)
# B 살충제의 경우 상자 폭이 좁고 평균이 높아 안정적임 (성능 가장 좋다고 판단)
