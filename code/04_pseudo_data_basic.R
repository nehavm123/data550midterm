library(here)
library(dplyr)

# Here Command
here::i_am("code/04_pseudo_data_basic.R")
# 创建基础伪数据
basic_data <- data.frame(
  USMER = c("No", "Yes"),
  MEDICAL_UNIT = c(12, 6),
  SEX = c("male", "female"),
  PATIENT_TYPE = c("hospitalization", "returned home"),
  DATE_DIED = c(NA, "2020-03-31"),
  INTUBED = c("No", "NA"),
  PNEUMONIA = c("Yes", "No"),
  AGE = c(64, 25),
  PREGNANT = c("NA", "No"),
  DIABETES = c("Yes", "No"),
  COPD = c("No", "Yes"),
  ASTHMA = c("No", "No"),
  INMSUPR = c("No", "Yes"),
  HIPERTENSION = c("Yes", "No"),
  OTHER_DISEASE = c("No", "No"),
  CARDIOVASCULAR = c("Yes", "No"),
  OBESITY = c("No", "Yes"),
  RENAL_CHRONIC = c("No", "No"),
  TOBACCO = c("No", "Yes"),
  CLASIFFICATION_FINAL = c(3, 7),
  ICU = c("No", "NA")
)

# 保存文件
write.csv(basic_data, file = here::here("data/pseudo_data_basic.csv"), row.names = FALSE)

# 模拟新增数据
added_data <- basic_data %>%
  slice(rep(1:n(), each = 3)) %>%  # 复制 3 倍数据
  mutate(AGE = AGE + sample(-5:5, n(), replace = TRUE))  # 随机调整年龄

# 保存文件
write.csv(added_data, file = here::here("data/pseudo_data_added.csv"), row.names = FALSE)

# 模拟删除数据
removed_data <- basic_data %>%
  slice(1)  # 仅保留第一条记录

# 保存文件
write.csv(removed_data, file = here::here("data/pseudo_data_removed.csv"), row.names = FALSE)
