#### [책] 빅데이터분석 R프로그래밍으로 시작하기

# 분석설계 >> 데이터 수집 >> 데이터 전처리 >> 데이터 분석 >> 결론 도출 

# Ctrl+Enter    : 코드 실행
# Ctrl+Alt+R    : 모든 코드 실행
# Ctrl+Shift+N  : 새 스크립트 생성

install.packages("dplyr")   # 패키지 설치 (한번만 설치하면 됨)
library(dplyr)              # 패키지 불러오기
# require(dplyr) 또한 패키지 불러오기
help(dplyr)                 # 만약 함수를 잘 모를 경우 help 사용

#----------------------------------------------------------------------------------------#

## 데이터 형태

# 벡터
vector1=c(1,2,3,4)              # c()이용해서 벡터 생성
str(vector1) ; length(vector1)  # 데이터형(수치형)과 길이(4)
typeof(vector1)                 # 데이터형만 파악

vector2=c("R","Hello")
str(vector2) ; length(vector2)  # 데이터형(문자형)과 길이(2)

vector3=c(TRUE,FALSE)
str(vector3) ; length(vector3)  # 데이터형(논리형)과 길이(2)

# 행렬
matrix(c(1:6),nrow=3,ncol=2)                # 1~6까지 3X2 행렬 생성(상에서 하로)
matrix(c(1:6),nrow=3,ncol=2, byrow = T)     # 1~6까지 3X2 행렬 생성(좌에서 우로)
# nrow와 ncol을 이용해서 R X C 행렬 생성

# 배열
array(c(1:6),dim=c(3,2,2))    # 3행 2열 2차원
# dim=c(행 수, 열 수, 차원 수)

# 리스트
list(c(1,2,3),"R")                        # 두 가지 데이터형(수치, 문자)을 가질 수 있다.
vector=c(1,2,3,"R") ; str(vector)         # 수치, 문자 같이 있는 경우 벡터는 문자형 데이터
vector=c(1,2,TRUE,FALSE) ; str(vector)    # 수치, 논리 같이 있는 경우 벡터는 수치형 데이터
vector=c(TRUE,FALSE,"R") ; str(vector)    # 논리, 문자 같이 있는 경우 벡터는 문자형 데이터
# 우선순위 : 문자 > 수치 > 논리 


# 데이터 프레임
df=data.frame(ID=c(1,2),GENDER=c("M","F"),AREA=c("한국","미국"))
df ; str(df)        # 데이터 프레임의 경우 변수명 적어주기 (각 변수 길이 동일해야 함)


# 단일형(문자, 수치 하나만) -> 벡터 or 행렬 or 배열
# 다중형(ex : 문자 + 수치)  -> 리스트 or 데이터프레임